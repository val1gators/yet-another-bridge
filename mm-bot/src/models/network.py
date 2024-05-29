from enum import Enum
from src.config import constants


class Network(Enum):
    STARKNET = constants.STARKNET_CHAIN_ID
    ZKSYNC = constants.ZKSYNC_CHAIN_ID
    