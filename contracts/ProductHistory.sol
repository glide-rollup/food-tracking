// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library ProductHistory {
    enum History {
        Created,
        Updated,
        Deleted,
        Sold,
        Purchased,
        Shipped,
        Received,
        Paid
    }
}
