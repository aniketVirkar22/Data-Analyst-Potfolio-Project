--Chane Y N to Yes and No in sold as vacant
SELECT DISTINCT(SoldAsVacant) 
FROM NashvilleHousing

SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes' 
	 WHEN SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END
FROM NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes' 
					WHEN SoldAsVacant = 'N' THEN 'No'
					ELSE SoldAsVacant
					END
FROM NashvilleHousing

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM NashvilleHousing
GROUP BY SoldAsVacant


--Removing duplicates
WITH RowNumCTE AS (SELECT *,
ROW_NUMBER() OVER ( PARTITION BY ParcelID,
								 PropertyAddress,
								 SalePrice,
								 SaleDate,
								 LegalReference
								 ORDER BY UniqueID ) AS rowNum FROM NashvilleHousing )

SELECT * FROM
RowNumCTE
WHERE rowNum > 1

DELETE 
FROM RowNumCTE
WHERE rowNum > 1

--Deleting waste unuswd columns

SELECT *
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
DROP COLUMN PropertyAddress, SaleDate, OwnerAddress, TaxDistrict

SELECT SalesDateNew, AddressFull, AddressCity, AddressCity
FROM NashvilleHousing

