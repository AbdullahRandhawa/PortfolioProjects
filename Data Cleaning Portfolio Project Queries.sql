/*

      Cleaning Data in SQL Queries

*/


Select *
From PortfoliProject..NashvilleHousing


-------------------------------------------------------------------------------------------------


-- Standardize Date Format


Select SaleDateConverted , CONVERT(date,Saledate)
From PortfoliProject..NashvilleHousing

update NashvilleHousing
set Saledate = CONVERT(date, SaleDate)

Alter table NashvilleHousing
Add SaleDateConverted date

update NashvilleHousing
set SaleDateConverted = CONVERT(date, SaleDate)


-------------------------------------------------------------------------------------------------


-- Popular Property Address Data


Select *
From PortfoliProject..NashvilleHousing
--where PropertyAddress is NULL
order by ParcelID

Select a.ParcelID,b.ParcelID,a.[UniqueID ],b.[UniqueID ],a.PropertyAddress,b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfoliProject..NashvilleHousing a
join PortfoliProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	And a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is NULL


Update a
Set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfoliProject..NashvilleHousing a
join PortfoliProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	And a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is NULL


-------------------------------------------------------------------------------------------------


-- Breaking Out Address into Individual Columns (Address, City, State)


Select SUBSTRING(PropertyAddress,1,CHARINDEX(',', Propertyaddress)-1 ) as Address,
	SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1,len(PropertyAddress)) as Address
From PortfoliProject..NashvilleHousing


Alter table NashvilleHousing
Add PropertySplitAddress NVARCHAR(255);

Update NashvilleHousing
Set PropertySplitAddress = SUBSTRING(PropertyAddress,1,CHARINDEX(',', Propertyaddress)-1 )




Alter table NashvilleHousing
Add PropertySplitCity NVARCHAR(255);

Update NashvilleHousing
Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1,len(PropertyAddress))



---------------------------------------------------------------------------------------------------


-- Change Y and N to Yess and No in "Sold as Vacant"


Select Distinct(SoldAsVacant), COUNT(SoldAsVacant)
From PortfoliProject..NashvilleHousing
group by SoldAsVacant
order by  2

Update NashvilleHousing
Set SoldAsVacant=
CASE when SoldAsVacant= 'Y' then 'Yes'
	 when SoldAsVacant = 'N' then 'No'
	 Else SoldAsVacant
End 


--------------------------------------------------------------------------------------------------


-- Remove Duplicate


Select *,
	ROW_NUMBER() OVER( PARTITION BY ParcelID,
								PropertyAddress,
								SalePrice,
								SaleDate,
								LegalReference
								order by UniqueID
								) row_num
FROM PortfoliProject.dbo.NashvilleHousing;

WITH RowNumCTE AS(
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference ORDER BY UniqueID) AS row_num
  FROM PortfoliProject.dbo.NashvilleHousing
)
select *
from RowNumCTE
where row_num >1
order by PropertyAddress


---------------------------------------------------------------------------------------------


-- Delete Unused Column


Select *
FROM PortfoliProject.dbo.NashvilleHousing


Alter table PortfoliProject.dbo.NashvilleHousing
Drop column OwnerAddress, TaxDistrict, PropertyAddress

Alter table PortfoliProject.dbo.NashvilleHousing
Drop column SaleDate