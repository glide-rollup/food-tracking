// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ProductsType.sol";
import "./ProductShippingStatus.sol";
import "./ProductPaymentStatus.sol";

contract ProductManagement {

    struct ProductInput {
        string manufacturer;
        string nameProduct;
        string originPlace;
        string composition;
        uint quantityUnit;
        string imageProduct;
        string productCode;
        uint price;
        ProductsType.Type productType;
    }

    struct Product {
        string manufacturer;
        string nameProduct;
        string originPlace;
        string composition;
        uint quantityUnit;
        string imageProduct;
        string productCode;
        string barcodeProduct;
        uint timestamp;
        uint price;
        ProductsType.Type productType;
        bool available;
        ProductShippingStatus.Status shippingStatus;
        ProductPaymentStatus.Status paymentStatus;
    }

    mapping(string => Product) public products; // Key: productCode

    function addProduct(ProductInput memory input) public {
        products[input.productCode] = Product({
            manufacturer: input.manufacturer,
            nameProduct: input.nameProduct,
            originPlace: input.originPlace,
            composition: input.composition,
            quantityUnit: input.quantityUnit,
            imageProduct: input.imageProduct,
            productCode: input.productCode,
            barcodeProduct: generateBarcode(input.productCode),
            timestamp: block.timestamp,
            price: input.price,
            productType: input.productType,
            available: true,
            shippingStatus: ProductShippingStatus.Status.InTransit,
            paymentStatus: ProductPaymentStatus.Status.Pending
        });
    }

    function updateProduct(
        string memory _productCode,
        string memory _nameProduct,
        string memory _originPlace,
        string memory _composition,
        uint _quantityUnit,
        string memory _imageProduct,
        uint _price,
        bool _available
    ) public {
        Product storage product = products[_productCode];
        product.nameProduct = _nameProduct;
        product.originPlace = _originPlace;
        product.composition = _composition;
        product.quantityUnit = _quantityUnit;
        product.imageProduct = _imageProduct;
        product.price = _price;
        product.available = _available;
        product.timestamp = block.timestamp;
    }

    function deleteProduct(string memory _productCode) public {
        delete products[_productCode];
    }

    function generateBarcode(string memory _productCode) private pure returns (string memory) {
        return string(abi.encodePacked("BARCODE-", _productCode));
    }
}
