/*
Covid 19 Data Exploration 
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/

Select *
From PortfolioProject..[Covid Deaths Edited]
Where continent is not null
Order by 3,4


--Select data to start with
Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..[Covid Deaths Edited]
Where continent is not null
Order by 1,2


--Total Cases vs Total Deaths
--Shows likelihood of death when an individual contracts Covid in each country from their first case - Feb 16, 2022
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
From PortfolioProject..[Covid Deaths Edited]
Where continent is not null
Order by 1,2


--Total cases vs Population
--Shows percentage of population got Covid
Select Location, date, total_cases, population, (total_cases/population)*100 as population_infected_percentage
From PortfolioProject..[Covid Deaths Edited]
Where continent is not null
Order by 1,2


--Countries with the highest infection rate compared to population
Select Location, MAX(total_cases) as highest_infection_count, population, MAX((total_cases/population))*100 as population_infected_percentage
From PortfolioProject..[Covid Deaths Edited]
Where continent is not null
Group by location, population
Order by 4 desc


--Countries with the highest death count 
Select Location, MAX(cast(total_deaths as int)) as highest_death_count
From PortfolioProject..[Covid Deaths Edited]
Where continent is not null
Group by location
Order by 2 desc


--Continents with the highest death count
Select continent, MAX(cast(total_deaths as int)) as highest_death_count
From PortfolioProject..[Covid Deaths Edited]
Where continent is not null
Group by continent
Order by 2 desc


-- Death percentage globally per date
Select date, SUM(new_cases), SUM(cast(new_deaths as int)), SUM(cast(new_deaths as int))/SUM(new_cases) as Death_Percentage
From PortfolioProject..[Covid Deaths Edited]
Where continent is not null
Group by date
Order by 1,2


-- Death percentage globally as of Feb 16, 2022
Select SUM(new_cases)as All_Cases, SUM(cast(new_deaths as int))as All_Deaths, SUM(cast(new_deaths as int))/SUM(new_cases) as Death_Percentage
From PortfolioProject..[Covid Deaths Edited]
Where continent is not null
Order by 1,2


-- Total population vs Total vaccination
-- Shows the percentage of population that has received the Covid Vaccine
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as Counting_Population_Vaccinated
From PortfolioProject..[Covid Deaths Edited] dea
Join PortfolioProject..[Covid Vaccinations Edited] vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null


-- Using CTE to perform the calculation on the Partition By value in previous query
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, Counting_People_Vaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as Counting_Population_Vaccinated
From PortfolioProject..[Covid Deaths Edited] dea
Join PortfolioProject..[Covid Vaccinations Edited] vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
)
Select *, (Counting_People_Vaccinated/population)*100 as Percentage_of_Population_Vaccinated
From PopvsVac


-- Using Temp Table to perform Calculation on Partition By in previous query
DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..[Covid Deaths Edited] dea
Join PortfolioProject..[Covid Vaccinations Edited] vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


-- Creating view to store data for later visualizations

Create View HighestInfectionRateCountries 
as
Select Location, MAX(total_cases) as highest_infection_count, population, MAX((total_cases/population))*100 as population_infected_percentage
From PortfolioProject..[Covid Deaths Edited]
Where continent is not null
Group by location, population

Create View VaccinationCount
as
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, Counting_People_Vaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location Order by dea.location, dea.date) as Counting_Population_Vaccinated
From PortfolioProject..[Covid Deaths Edited] dea
Join PortfolioProject..[Covid Vaccinations Edited] vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
)
Select *, (Counting_People_Vaccinated/population)*100 as Percentage_of_Population_Vaccinated
From PopvsVac
