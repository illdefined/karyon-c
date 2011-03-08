#include <emptyIDT>

const struct IDT emptyIDT = {
	UINT16(0),
	UINT64(0)
};
