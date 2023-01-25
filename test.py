import torch
import workflowtest

if __name__ == "__main__":
    hashmap_keys = torch.zeros(
            2 * 100, dtype=torch.int64, device="cuda"
        )
    hashmap_vals = torch.zeros(
            2 * 100, dtype=torch.int32, device="cuda"
        )
    hashmap = workflowtest.GPUHashTable(hashmap_keys, hashmap_vals)
