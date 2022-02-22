/*

Cleaning data in SQL Queries

*/

Select *
From PortfolioProject..[Nashville Housing]



-- Standardized Date Format

Select saleDateConverted, CONVERT(Date,SaleDate)
From PortfolioProject..[Nashville Housing]

Update [Nashville Housing]
SET SaleDate = CONVERT(Date,SaleDate)

-- If it doesn't Update properly

ALTER TABLE [Nashville Housing]
Add SaleDateConverted Date;

Update [Nashville Housing]
SET SaleDateConverted = CONVERT(Date,SaleDate)






-- Populate Property Address data

Select *
From PortfolioProject..[Nashville Housing]
--Where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject..[Nashville Housing] a
JOIN PortfolioProject..[Nashville Housing] b
	On a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject..[Nashville Housing] a
JOIN PortfolioProject..[Nashville Housing] b
	On a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null







-- Breaking down address into their own columns (Address, City, State)

Select *
From PortfolioProject..[Nashville Housing]
--Where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING (PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
From PortfolioProject..[Nashville Housing]


ALTER TABLE [Nashville Housing]
Add PropertySplitAddress Nvarchar(255);

Update [Nashville Housing]
SET PropertySplitAddress = SUBSTRING (PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

ALTER TABLE [Nashville Housing]
Add PropertySplitCity Nvarchar(255);

Update [Nashville Housing]
SET PropertySplitCity = SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

Select *
From PortfolioProject..[Nashville Housing]

-- Alternate way of splitting without using SUBSTRING. Instead using PARSENAME

Select OwnerAddress
From PortfolioProject..[Nashville Housing]

Select
PARSENAME(Replace(OwnerAddress, ',', '.'), 3)
, PARSENAME(Replace(OwnerAddress, ',', '.'), 2)
, PARSENAME(Replace(OwnerAddress, ',', '.'), 1)
From PortfolioProject..[Nashville Housing]

ALTER TABLE [Nashville Housing]
Add OwnerSplitAddress Nvarchar(255);

Update [Nashville Housing]
SET OwnerSplitAddress = PARSENAME(Replace(OwnerAddress, ',', '.'), 3)

ALTER TABLE [Nashville Housing]
Add OwnerSplitCity Nvarchar(255);

Update [Nashville Housing]
SET OwnerSplitCity = PARSENAME(Replace(OwnerAddress, ',', '.'), 2)

ALTER TABLE [Nashville Housing]
Add OwnerSplitState Nvarchar(255);

Update [Nashville Housing]
SET OwnerSplitState = PARSENAME(Replace(OwnerAddress, ',', '.'), 1)

Select *
From PortfolioProject..[Nashville Housing]






-- Change Y and N to Yes and No in Sold as Vacant field

Select Distinct(SoldAsVacant), COUNT(SoldAsVacant)
From PortfolioProject..[Nashville Housing]
Group by SoldAsVacant
Order by 2

Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From PortfolioProject..[Nashville Housing]

Update [Nashville Housing]
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END







-- Remove Duplicates

WITH RowNumCTE as(
Select *,
	ROW_NUMBER() OVER(Partition by ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference 
	Order by UniqueID) row_num
From PortfolioProject..[Nashville Housing]
)
DELETE
From RowNumCTE
Where row_num > 1







-- Delete unused columns. Now that we have split the owner address and property address into much more useful columns, we can delete the original property address and owner address columns along with other columns that we don't need


Select *
From PortfolioProject..[Nashville Housing]

ALTER TABLE PortfolioProject..[Nashville Housing]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate
