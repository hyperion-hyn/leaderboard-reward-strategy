//SPDX-License-Identifier: MIT License
pragma solidity ^0.8.6;

library DLL {
    uint256 internal constant NULL_NODE_ID = 0;

    struct Node {
        uint256 next;
        uint256 prev;
    }

    struct Data {
        mapping(uint256 => Node) dll;
    }

    function isEmpty(Data storage self) internal view returns (bool) {
        return getStart(self) == NULL_NODE_ID;
    }

    function contains(Data storage self, uint256 _curr)
        internal
        view
        returns (bool)
    {
        if (isEmpty(self) || _curr == NULL_NODE_ID) {
            return false;
        }

        bool isSingleNode = (getStart(self) == _curr) &&
            (getEnd(self) == _curr);
        bool isNullNode = (getNext(self, _curr) == NULL_NODE_ID) &&
            (getPrev(self, _curr) == NULL_NODE_ID);
        return isSingleNode || !isNullNode;
    }

    function getNext(Data storage self, uint256 _curr)
        internal
        view
        returns (uint256)
    {
        return self.dll[_curr].next;
    }

    function getPrev(Data storage self, uint256 _curr)
        internal
        view
        returns (uint256)
    {
        return self.dll[_curr].prev;
    }

    function getStart(Data storage self) internal view returns (uint256) {
        return getNext(self, NULL_NODE_ID);
    }

    function getEnd(Data storage self) internal view returns (uint256) {
        return getPrev(self, NULL_NODE_ID);
    }

    /**
    @dev Inserts a new node between _prev and _next. When inserting a node already existing in
    the list it will be automatically removed from the old position.
    @param _prev the node which _new will be inserted after
    @param _curr the id of the new node being inserted
    @param _next the node which _new will be inserted before
    */
    function insert(
        Data storage self,
        uint256 _prev,
        uint256 _curr,
        uint256 _next
    ) internal {
        require(_curr != NULL_NODE_ID, "curr is zero");

        remove(self, _curr);

        require(_prev == NULL_NODE_ID || contains(self, _prev), "prev error");
        require(_next == NULL_NODE_ID || contains(self, _next), "next error");

        require(getNext(self, _prev) == _next, "next diff");
        require(getPrev(self, _next) == _prev, "prev diff");

        self.dll[_curr].prev = _prev;
        self.dll[_curr].next = _next;

        self.dll[_prev].next = _curr;
        self.dll[_next].prev = _curr;
    }

    function remove(Data storage self, uint256 _curr) internal {
        if (!contains(self, _curr)) {
            return;
        }

        uint256 next = getNext(self, _curr);
        uint256 prev = getPrev(self, _curr);

        self.dll[next].prev = prev;
        self.dll[prev].next = next;

        delete self.dll[_curr];
    }
}
