# vs-nlm-ispc
Non-local means denoise filter, drop-in replacement of the venerable [KNLMeansCL](https://github.com/Khanattila/KNLMeansCL), but without the OpenCL dependency (CPU only).

x86 and arm are supported.

## Usage
Prototype:

`core.nlm_ispc.NLMeans(clip clip[, int d = 1, int a = 2, int s = 4, float h = 1.2, string channels = "AUTO", int wmode = 0, float wref = 1.0f, clip rclip = None])`

## Compilation
[ISPC](https://github.com/ispc/ispc) is required.

### x86
```bash
cmake -S . -B build -D CMAKE_BUILD_TYPE=Release \
-D CMAKE_ISPC_INSTRUCTION_SETS="sse2-i32x4;avx1-i32x4;avx2-i32x8" \
-D CMAKE_ISPC_FLAGS="--opt=fast-math"

cmake --build build

cmake --install build
```

### arm
```bash
cmake -S . -B build -D CMAKE_BUILD_TYPE=Release \
-D CMAKE_ISPC_INSTRUCTION_SETS="neon-i32x4" \
-D CMAKE_ISPC_FLAGS="--opt=fast-math"

cmake --build build

cmake --install build
```

