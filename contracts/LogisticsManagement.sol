// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ProductShippingStatus.sol";
import "./ProductPaymentStatus.sol";

contract LogisticsManagement {

    struct ShipmentInput {
        string productCode;
        address from;
        address to;
        uint quantity;
        string imageProduct;
    }

    struct Shipment {
        string productCode;
        address from;
        address to;
        uint timestamp;
        uint quantity;
        string imageProduct;
        ProductShippingStatus.Status shippingStatus;
        ProductPaymentStatus.Status paymentStatus;
    }

    mapping(string => Shipment) public shipments; // Key: shipment id (productCode + from + to)

    function createShipment(ShipmentInput memory input) public {
        string memory shipmentId = generateShipmentId(input.productCode, input.from, input.to);
        shipments[shipmentId] = Shipment({
            productCode: input.productCode,
            from: input.from,
            to: input.to,
            timestamp: block.timestamp,
            quantity: input.quantity,
            imageProduct: input.imageProduct,
            shippingStatus: ProductShippingStatus.Status.InTransit,
            paymentStatus: ProductPaymentStatus.Status.Pending
        });
    }

    function updateShipmentStatus(
        string memory _productCode,
        address _from,
        address _to,
        ProductShippingStatus.Status _shippingStatus,
        ProductPaymentStatus.Status _paymentStatus
    ) public {
        string memory shipmentId = generateShipmentId(_productCode, _from, _to);
        Shipment storage shipment = shipments[shipmentId];
        shipment.shippingStatus = _shippingStatus;
        shipment.paymentStatus = _paymentStatus;
    }

    function generateShipmentId(string memory _productCode, address _from, address _to) private pure returns (string memory) {
        return string(abi.encodePacked(_productCode, "-", _from, "-", _to));
    }
}
