SELECT *
FROM NashvilleHousing

--Standardising date format
SELECT SaleDate, CONVERT(Date, SaleDate) AS Modified
FROM NashvilleHousing
ORDER BY 1,2

ALTER TABLE NashvilleHousing
ADD SalesDateNew Date;
UPDATE NashvilleHousing
SET SalesDateNew = CONVERT (Date,SaleDate)

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress IS NULL

--Seperating whole address into smaleer parts for property
SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',' , PropertyAddress) -1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',' , PropertyAddress) +1, LEN(PropertyAddress)) AS Addressn
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
ADD AddressFull nvarchar(255)
UPDATE NashvilleHousing
SET AddressFull = SUBSTRING(PropertyAddress, 1, CHARINDEX(',' , PropertyAddress) -1)

ALTER TABLE NashvilleHousing
ADD AddressCity nvarchar(255)
UPDATE NashvilleHousing
SET AddressCity = SUBSTRING(PropertyAddress, CHARINDEX(',' , PropertyAddress) +1, LEN(PropertyAddress))

--Seperating whole address into smaleer parts for owner

SELECT OwnerAddressFull, OwnerAddressCity, OwnerAddressState  --OwnerAddress
FROM NashvilleHousing

SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2), 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) 
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
ADD OwnerAddressFull nvarchar(255)
UPDATE NashvilleHousing
SET OwnerAddressFull = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

ALTER TABLE NashvilleHousing
ADD OwnerAddressCity nvarchar(255)
UPDATE NashvilleHousing
SET OwnerAddressCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE NashvilleHousing
ADD OwnerAddressState nvarchar(255)
UPDATE NashvilleHousing
SET OwnerAddressState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)