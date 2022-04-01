# vs-nlm-ispc
Non-local means denoise filter, drop-in replacement of the venerable [KNLMeansCL](https://github.com/Khanattila/KNLMeansCL), but without the OpenCL dependency (CPU only).

x86 and arm are supported.

## Note
The filter requires floating-point input. A simple wrapper could be

```python3
import vapoursynth as vs

def NLMeans(clip, d=1, a=2, s=4, h=1.2, channels="AUTO", wmode=0, wref=1.0, rclip=None):
    bits = clip.format.bits_per_sample

    if bits != 32:
        clip = clip.fmtc.bitdepth(bits=32)
        if rclip is not None:
            rclip = rclip.fmtc.bitdepth(bits=32)

    clip = clip.nlm_ispc.NLMeans(d, a, s, h, channels, wmode, wref, rclip)

    if bits != 32:
        cilp = clip.fmtc.bitdepth(bits=bits)

    return clip
```

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

