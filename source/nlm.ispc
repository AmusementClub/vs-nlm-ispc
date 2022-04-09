// based on KNLMeansCL by Khanattila and vs-boxblur

#define CLAMPX(x) clamp(x, 0, width - 1)
#define CLAMPY(y) clamp(y, 0, height - 1)

static inline uniform float square(uniform float x) {
    return x * x;
}

static inline float square(float x) {
    return x * x;
}

export void nlmDistanceLuma_f32(
    uniform float temp0[], // shape: (height, stride)
    uniform const float centerp[], // shape: (height, stride)
    uniform const float neighborp[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    for (uniform int y = 0; y < height ;y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;
            uniform float u1 = centerp[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq = neighborp[neighbor_idx];

            temp0[idx] = 3.0f * square(u1 - u1_pq);
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;
            float u1 = centerp[idx];

            int neighbor_idx = CLAMPY(y + offset_y) * stride + (x + offset_x);
            float u1_pq = neighborp[neighbor_idx];

            temp0[idx] = 3.0f * square(u1 - u1_pq);
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;
            uniform float u1 = centerp[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq = neighborp[neighbor_idx];

            temp0[idx] = 3.0f * square(u1 - u1_pq);
        }
    }
}

export void nlmDistanceLuma_u8(
    uniform float temp0[], // shape: (height, stride)
    uniform const unsigned int8 centerp[], // shape: (height, stride)
    uniform const unsigned int8 neighborp[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride,
    uniform float inv_divisor
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    uniform float sq_inv_divisor = square(inv_divisor);

    for (uniform int y = 0; y < height ;y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;
            uniform float u1 = centerp[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq = neighborp[neighbor_idx];

            temp0[idx] = 3.0f * square(u1 - u1_pq) * sq_inv_divisor;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;
            float u1 = centerp[idx];

            int neighbor_idx = CLAMPY(y + offset_y) * stride + (x + offset_x);
            float u1_pq = neighborp[neighbor_idx];

            temp0[idx] = 3.0f * square(u1 - u1_pq) * sq_inv_divisor;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;
            uniform float u1 = centerp[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq = neighborp[neighbor_idx];

            temp0[idx] = 3.0f * square(u1 - u1_pq) * sq_inv_divisor;
        }
    }
}

export void nlmDistanceLuma_u16(
    uniform float temp0[], // shape: (height, stride)
    uniform const unsigned int16 centerp[], // shape: (height, stride)
    uniform const unsigned int16 neighborp[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride,
    uniform float inv_divisor
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    uniform float sq_inv_divisor = square(inv_divisor);

    for (uniform int y = 0; y < height ;y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;
            uniform float u1 = centerp[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq = neighborp[neighbor_idx];

            temp0[idx] = 3.0f * square(u1 - u1_pq) * sq_inv_divisor;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;
            float u1 = centerp[idx];

            int neighbor_idx = CLAMPY(y + offset_y) * stride + (x + offset_x);
            float u1_pq = neighborp[neighbor_idx];

            temp0[idx] = 3.0f * square(u1 - u1_pq) * sq_inv_divisor;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;
            uniform float u1 = centerp[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq = neighborp[neighbor_idx];

            temp0[idx] = 3.0f * square(u1 - u1_pq) * sq_inv_divisor;
        }
    }
}

export void nlmDistanceChroma_f32(
    uniform float temp0[], // shape: (height, stride)
    uniform const float centerp1[], // shape: (height, stride)
    uniform const float centerp2[], // shape: (height, stride)
    uniform const float neighborp1[], // shape: (height, stride)
    uniform const float neighborp2[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;
            uniform float u1_1 = centerp1[idx];
            uniform float u1_2 = centerp2[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq_1 = neighborp1[neighbor_idx];
            uniform float u1_pq_2 = neighborp2[neighbor_idx];

            uniform float dst = 1.5f * (
                square(u1_1 - u1_pq_1) +
                square(u1_2 - u1_pq_2)
            );

            temp0[idx] = dst;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;
            float u1_1 = centerp1[idx];
            float u1_2 = centerp2[idx];

            int neighbor_idx = CLAMPY(y + offset_y) * stride + (x + offset_x);
            float u1_pq_1 = neighborp1[neighbor_idx];
            float u1_pq_2 = neighborp2[neighbor_idx];

            float dst = 1.5f * (
                square(u1_1 - u1_pq_1) +
                square(u1_2 - u1_pq_2)
            );

            temp0[idx] = dst;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;
            uniform float u1_1 = centerp1[idx];
            uniform float u1_2 = centerp2[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq_1 = neighborp1[neighbor_idx];
            uniform float u1_pq_2 = neighborp2[neighbor_idx];

            uniform float dst = 1.5f * (
                square(u1_1 - u1_pq_1) +
                square(u1_2 - u1_pq_2)
            );

            temp0[idx] = dst;
        }
    }
}

export void nlmDistanceChroma_u8(
    uniform float temp0[], // shape: (height, stride)
    uniform const unsigned int8 centerp1[], // shape: (height, stride)
    uniform const unsigned int8 centerp2[], // shape: (height, stride)
    uniform const unsigned int8 neighborp1[], // shape: (height, stride)
    uniform const unsigned int8 neighborp2[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride,
    uniform float inv_divisor
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    uniform float sq_inv_divisor = square(inv_divisor);

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;
            uniform float u1_1 = centerp1[idx];
            uniform float u1_2 = centerp2[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq_1 = neighborp1[neighbor_idx];
            uniform float u1_pq_2 = neighborp2[neighbor_idx];

            uniform float dst = 1.5f * (
                square(u1_1 - u1_pq_1) +
                square(u1_2 - u1_pq_2)
            );

            temp0[idx] = dst * sq_inv_divisor;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;
            float u1_1 = centerp1[idx];
            float u1_2 = centerp2[idx];

            int neighbor_idx = CLAMPY(y + offset_y) * stride + (x + offset_x);
            float u1_pq_1 = neighborp1[neighbor_idx];
            float u1_pq_2 = neighborp2[neighbor_idx];

            float dst = 1.5f * (
                square(u1_1 - u1_pq_1) +
                square(u1_2 - u1_pq_2)
            );

            temp0[idx] = dst * sq_inv_divisor;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;
            uniform float u1_1 = centerp1[idx];
            uniform float u1_2 = centerp2[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq_1 = neighborp1[neighbor_idx];
            uniform float u1_pq_2 = neighborp2[neighbor_idx];

            uniform float dst = 1.5f * (
                square(u1_1 - u1_pq_1) +
                square(u1_2 - u1_pq_2)
            );

            temp0[idx] = dst * sq_inv_divisor;
        }
    }
}

export void nlmDistanceChroma_u16(
    uniform float temp0[], // shape: (height, stride)
    uniform const unsigned int16 centerp1[], // shape: (height, stride)
    uniform const unsigned int16 centerp2[], // shape: (height, stride)
    uniform const unsigned int16 neighborp1[], // shape: (height, stride)
    uniform const unsigned int16 neighborp2[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride,
    uniform float inv_divisor
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    uniform float sq_inv_divisor = square(inv_divisor);

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;
            uniform float u1_1 = centerp1[idx];
            uniform float u1_2 = centerp2[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq_1 = neighborp1[neighbor_idx];
            uniform float u1_pq_2 = neighborp2[neighbor_idx];

            uniform float dst = 1.5f * (
                square(u1_1 - u1_pq_1) +
                square(u1_2 - u1_pq_2)
            );

            temp0[idx] = dst * sq_inv_divisor;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;
            float u1_1 = centerp1[idx];
            float u1_2 = centerp2[idx];

            int neighbor_idx = CLAMPY(y + offset_y) * stride + (x + offset_x);
            float u1_pq_1 = neighborp1[neighbor_idx];
            float u1_pq_2 = neighborp2[neighbor_idx];

            float dst = 1.5f * (
                square(u1_1 - u1_pq_1) +
                square(u1_2 - u1_pq_2)
            );

            temp0[idx] = dst * sq_inv_divisor;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;
            uniform float u1_1 = centerp1[idx];
            uniform float u1_2 = centerp2[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq_1 = neighborp1[neighbor_idx];
            uniform float u1_pq_2 = neighborp2[neighbor_idx];

            uniform float dst = 1.5f * (
                square(u1_1 - u1_pq_1) +
                square(u1_2 - u1_pq_2)
            );

            temp0[idx] = dst * sq_inv_divisor;
        }
    }
}

export void nlmDistanceYUV_f32(
    uniform float temp0[], // shape: (height, stride)
    uniform const float centerp1[], // shape: (height, stride)
    uniform const float centerp2[], // shape: (height, stride)
    uniform const float centerp3[], // shape: (height, stride)
    uniform const float neighborp1[], // shape: (height, stride)
    uniform const float neighborp2[], // shape: (height, stride)
    uniform const float neighborp3[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;
            uniform float u1_1 = centerp1[idx];
            uniform float u1_2 = centerp2[idx];
            uniform float u1_3 = centerp3[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq_1 = neighborp1[neighbor_idx];
            uniform float u1_pq_2 = neighborp2[neighbor_idx];
            uniform float u1_pq_3 = neighborp3[neighbor_idx];

            uniform float dst = (
                square(u1_1 - u1_pq_1) +
                square(u1_2 - u1_pq_2) +
                square(u1_3 - u1_pq_3)
            );

            temp0[idx] = dst;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;
            float u1_1 = centerp1[idx];
            float u1_2 = centerp2[idx];
            float u1_3 = centerp3[idx];

            int neighbor_idx = CLAMPY(y + offset_y) * stride + (x + offset_x);
            float u1_pq_1 = neighborp1[neighbor_idx];
            float u1_pq_2 = neighborp2[neighbor_idx];
            float u1_pq_3 = neighborp3[neighbor_idx];

            float dst = (
                square(u1_1 - u1_pq_1) +
                square(u1_2 - u1_pq_2) +
                square(u1_3 - u1_pq_3)
            );

            temp0[idx] = dst;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;
            uniform float u1_1 = centerp1[idx];
            uniform float u1_2 = centerp2[idx];
            uniform float u1_3 = centerp3[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq_1 = neighborp1[neighbor_idx];
            uniform float u1_pq_2 = neighborp2[neighbor_idx];
            uniform float u1_pq_3 = neighborp3[neighbor_idx];

            uniform float dst = (
                square(u1_1 - u1_pq_1) +
                square(u1_2 - u1_pq_2) +
                square(u1_3 - u1_pq_3)
            );

            temp0[idx] = dst;
        }
    }
}

export void nlmDistanceYUV_u8(
    uniform float temp0[], // shape: (height, stride)
    uniform const unsigned int8 centerp1[], // shape: (height, stride)
    uniform const unsigned int8 centerp2[], // shape: (height, stride)
    uniform const unsigned int8 centerp3[], // shape: (height, stride)
    uniform const unsigned int8 neighborp1[], // shape: (height, stride)
    uniform const unsigned int8 neighborp2[], // shape: (height, stride)
    uniform const unsigned int8 neighborp3[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride,
    uniform float inv_divisor
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    uniform float sq_inv_divisor = square(inv_divisor);

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;
            uniform float u1_1 = centerp1[idx];
            uniform float u1_2 = centerp2[idx];
            uniform float u1_3 = centerp3[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq_1 = neighborp1[neighbor_idx];
            uniform float u1_pq_2 = neighborp2[neighbor_idx];
            uniform float u1_pq_3 = neighborp3[neighbor_idx];

            uniform float dst = (
                square(u1_1 - u1_pq_1) +
                square(u1_2 - u1_pq_2) +
                square(u1_3 - u1_pq_3)
            );

            temp0[idx] = dst * sq_inv_divisor;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;
            float u1_1 = centerp1[idx];
            float u1_2 = centerp2[idx];
            float u1_3 = centerp3[idx];

            int neighbor_idx = CLAMPY(y + offset_y) * stride + (x + offset_x);
            float u1_pq_1 = neighborp1[neighbor_idx];
            float u1_pq_2 = neighborp2[neighbor_idx];
            float u1_pq_3 = neighborp3[neighbor_idx];

            float dst = (
                square(u1_1 - u1_pq_1) +
                square(u1_2 - u1_pq_2) +
                square(u1_3 - u1_pq_3)
            );

            temp0[idx] = dst * sq_inv_divisor;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;
            uniform float u1_1 = centerp1[idx];
            uniform float u1_2 = centerp2[idx];
            uniform float u1_3 = centerp3[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq_1 = neighborp1[neighbor_idx];
            uniform float u1_pq_2 = neighborp2[neighbor_idx];
            uniform float u1_pq_3 = neighborp3[neighbor_idx];

            uniform float dst = (
                square(u1_1 - u1_pq_1) +
                square(u1_2 - u1_pq_2) +
                square(u1_3 - u1_pq_3)
            );

            temp0[idx] = dst * sq_inv_divisor;
        }
    }
}

export void nlmDistanceYUV_u16(
    uniform float temp0[], // shape: (height, stride)
    uniform const unsigned int16 centerp1[], // shape: (height, stride)
    uniform const unsigned int16 centerp2[], // shape: (height, stride)
    uniform const unsigned int16 centerp3[], // shape: (height, stride)
    uniform const unsigned int16 neighborp1[], // shape: (height, stride)
    uniform const unsigned int16 neighborp2[], // shape: (height, stride)
    uniform const unsigned int16 neighborp3[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride,
    uniform float inv_divisor
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    uniform float sq_inv_divisor = square(inv_divisor);

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;
            uniform float u1_1 = centerp1[idx];
            uniform float u1_2 = centerp2[idx];
            uniform float u1_3 = centerp3[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq_1 = neighborp1[neighbor_idx];
            uniform float u1_pq_2 = neighborp2[neighbor_idx];
            uniform float u1_pq_3 = neighborp3[neighbor_idx];

            uniform float dst = (
                square(u1_1 - u1_pq_1) +
                square(u1_2 - u1_pq_2) +
                square(u1_3 - u1_pq_3)
            );

            temp0[idx] = dst * sq_inv_divisor;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;
            float u1_1 = centerp1[idx];
            float u1_2 = centerp2[idx];
            float u1_3 = centerp3[idx];

            int neighbor_idx = CLAMPY(y + offset_y) * stride + (x + offset_x);
            float u1_pq_1 = neighborp1[neighbor_idx];
            float u1_pq_2 = neighborp2[neighbor_idx];
            float u1_pq_3 = neighborp3[neighbor_idx];

            float dst = (
                square(u1_1 - u1_pq_1) +
                square(u1_2 - u1_pq_2) +
                square(u1_3 - u1_pq_3)
            );

            temp0[idx] = dst * sq_inv_divisor;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;
            uniform float u1_1 = centerp1[idx];
            uniform float u1_2 = centerp2[idx];
            uniform float u1_3 = centerp3[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq_1 = neighborp1[neighbor_idx];
            uniform float u1_pq_2 = neighborp2[neighbor_idx];
            uniform float u1_pq_3 = neighborp3[neighbor_idx];

            uniform float dst = (
                square(u1_1 - u1_pq_1) +
                square(u1_2 - u1_pq_2) +
                square(u1_3 - u1_pq_3)
            );

            temp0[idx] = dst * sq_inv_divisor;
        }
    }
}

export void nlmDistanceRGB_f32(
    uniform float temp0[], // shape: (height, stride)
    uniform const float centerp1[], // shape: (height, stride)
    uniform const float centerp2[], // shape: (height, stride)
    uniform const float centerp3[], // shape: (height, stride)
    uniform const float neighborp1[], // shape: (height, stride)
    uniform const float neighborp2[], // shape: (height, stride)
    uniform const float neighborp3[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;
            uniform float u1_1 = centerp1[idx];
            uniform float u1_2 = centerp2[idx];
            uniform float u1_3 = centerp3[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq_1 = neighborp1[neighbor_idx];
            uniform float u1_pq_2 = neighborp2[neighbor_idx];
            uniform float u1_pq_3 = neighborp3[neighbor_idx];

            uniform float m_red = (u1_1 + u1_pq_1) / 6.0f;

            uniform float dst = (
                (2.0f / 3.0f + m_red) * square(u1_1 - u1_pq_1) +
                (4.0f / 3.0f) * square(u1_2 - u1_pq_2) +
                (1.0f - m_red) * square(u1_3 - u1_pq_3)
            );

            temp0[idx] = dst;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;
            float u1_1 = centerp1[idx];
            float u1_2 = centerp2[idx];
            float u1_3 = centerp3[idx];

            int neighbor_idx = CLAMPY(y + offset_y) * stride + (x + offset_x);
            float u1_pq_1 = neighborp1[neighbor_idx];
            float u1_pq_2 = neighborp2[neighbor_idx];
            float u1_pq_3 = neighborp3[neighbor_idx];

            float m_red = (u1_1 + u1_pq_1) / 6.0f;

            float dst = (
                (2.0f / 3.0f + m_red) * square(u1_1 - u1_pq_1) +
                (4.0f / 3.0f) * square(u1_2 - u1_pq_2) +
                (1.0f - m_red) * square(u1_3 - u1_pq_3)
            );

            temp0[idx] = dst;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;
            uniform float u1_1 = centerp1[idx];
            uniform float u1_2 = centerp2[idx];
            uniform float u1_3 = centerp3[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq_1 = neighborp1[neighbor_idx];
            uniform float u1_pq_2 = neighborp2[neighbor_idx];
            uniform float u1_pq_3 = neighborp3[neighbor_idx];

            uniform float m_red = (u1_1 + u1_pq_1) / 6.0f;

            uniform float dst = (
                (2.0f / 3.0f + m_red) * square(u1_1 - u1_pq_1) +
                (4.0f / 3.0f) * square(u1_2 - u1_pq_2) +
                (1.0f - m_red) * square(u1_3 - u1_pq_3)
            );

            temp0[idx] = dst;
        }
    }
}

export void nlmDistanceRGB_u8(
    uniform float temp0[], // shape: (height, stride)
    uniform const unsigned int8 centerp1[], // shape: (height, stride)
    uniform const unsigned int8 centerp2[], // shape: (height, stride)
    uniform const unsigned int8 centerp3[], // shape: (height, stride)
    uniform const unsigned int8 neighborp1[], // shape: (height, stride)
    uniform const unsigned int8 neighborp2[], // shape: (height, stride)
    uniform const unsigned int8 neighborp3[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride,
    uniform float inv_divisor
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    uniform float sq_inv_divisor = square(inv_divisor);

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;
            uniform float u1_1 = centerp1[idx];
            uniform float u1_2 = centerp2[idx];
            uniform float u1_3 = centerp3[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq_1 = neighborp1[neighbor_idx];
            uniform float u1_pq_2 = neighborp2[neighbor_idx];
            uniform float u1_pq_3 = neighborp3[neighbor_idx];

            uniform float m_red = (u1_1 + u1_pq_1) / 6.0f * inv_divisor;

            uniform float dst = (
                (2.0f / 3.0f + m_red) * square(u1_1 - u1_pq_1) +
                (4.0f / 3.0f) * square(u1_2 - u1_pq_2) +
                (1.0f - m_red) * square(u1_3 - u1_pq_3)
            );

            temp0[idx] = dst * sq_inv_divisor;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;
            float u1_1 = centerp1[idx];
            float u1_2 = centerp2[idx];
            float u1_3 = centerp3[idx];

            int neighbor_idx = CLAMPY(y + offset_y) * stride + (x + offset_x);
            float u1_pq_1 = neighborp1[neighbor_idx];
            float u1_pq_2 = neighborp2[neighbor_idx];
            float u1_pq_3 = neighborp3[neighbor_idx];

            float m_red = (u1_1 + u1_pq_1) / 6.0f * inv_divisor;

            float dst = (
                (2.0f / 3.0f + m_red) * square(u1_1 - u1_pq_1) +
                (4.0f / 3.0f) * square(u1_2 - u1_pq_2) +
                (1.0f - m_red) * square(u1_3 - u1_pq_3)
            );

            temp0[idx] = dst * sq_inv_divisor;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;
            uniform float u1_1 = centerp1[idx];
            uniform float u1_2 = centerp2[idx];
            uniform float u1_3 = centerp3[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq_1 = neighborp1[neighbor_idx];
            uniform float u1_pq_2 = neighborp2[neighbor_idx];
            uniform float u1_pq_3 = neighborp3[neighbor_idx];

            uniform float m_red = (u1_1 + u1_pq_1) / 6.0f * inv_divisor;

            uniform float dst = (
                (2.0f / 3.0f + m_red) * square(u1_1 - u1_pq_1) +
                (4.0f / 3.0f) * square(u1_2 - u1_pq_2) +
                (1.0f - m_red) * square(u1_3 - u1_pq_3)
            );

            temp0[idx] = dst * sq_inv_divisor;
        }
    }
}

export void nlmDistanceRGB_u16(
    uniform float temp0[], // shape: (height, stride)
    uniform const unsigned int16 centerp1[], // shape: (height, stride)
    uniform const unsigned int16 centerp2[], // shape: (height, stride)
    uniform const unsigned int16 centerp3[], // shape: (height, stride)
    uniform const unsigned int16 neighborp1[], // shape: (height, stride)
    uniform const unsigned int16 neighborp2[], // shape: (height, stride)
    uniform const unsigned int16 neighborp3[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride,
    uniform float inv_divisor
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    uniform float sq_inv_divisor = square(inv_divisor);

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;
            uniform float u1_1 = centerp1[idx];
            uniform float u1_2 = centerp2[idx];
            uniform float u1_3 = centerp3[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq_1 = neighborp1[neighbor_idx];
            uniform float u1_pq_2 = neighborp2[neighbor_idx];
            uniform float u1_pq_3 = neighborp3[neighbor_idx];

            uniform float m_red = (u1_1 + u1_pq_1) / 6.0f * inv_divisor;

            uniform float dst = (
                (2.0f / 3.0f + m_red) * square(u1_1 - u1_pq_1) +
                (4.0f / 3.0f) * square(u1_2 - u1_pq_2) +
                (1.0f - m_red) * square(u1_3 - u1_pq_3)
            );

            temp0[idx] = dst * sq_inv_divisor;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;
            float u1_1 = centerp1[idx];
            float u1_2 = centerp2[idx];
            float u1_3 = centerp3[idx];

            int neighbor_idx = CLAMPY(y + offset_y) * stride + (x + offset_x);
            float u1_pq_1 = neighborp1[neighbor_idx];
            float u1_pq_2 = neighborp2[neighbor_idx];
            float u1_pq_3 = neighborp3[neighbor_idx];

            float m_red = (u1_1 + u1_pq_1) / 6.0f * inv_divisor;

            float dst = (
                (2.0f / 3.0f + m_red) * square(u1_1 - u1_pq_1) +
                (4.0f / 3.0f) * square(u1_2 - u1_pq_2) +
                (1.0f - m_red) * square(u1_3 - u1_pq_3)
            );

            temp0[idx] = dst * sq_inv_divisor;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;
            uniform float u1_1 = centerp1[idx];
            uniform float u1_2 = centerp2[idx];
            uniform float u1_3 = centerp3[idx];

            uniform int neighbor_idx = CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x);
            uniform float u1_pq_1 = neighborp1[neighbor_idx];
            uniform float u1_pq_2 = neighborp2[neighbor_idx];
            uniform float u1_pq_3 = neighborp3[neighbor_idx];

            uniform float m_red = (u1_1 + u1_pq_1) / 6.0f * inv_divisor;

            uniform float dst = (
                (2.0f / 3.0f + m_red) * square(u1_1 - u1_pq_1) +
                (4.0f / 3.0f) * square(u1_2 - u1_pq_2) +
                (1.0f - m_red) * square(u1_3 - u1_pq_3)
            );

            temp0[idx] = dst * sq_inv_divisor;
        }
    }
}

// manually unrolled nlmHorizontal()
static void nlmHorizontalS0(
    uniform float temp0[], // shape: (height, stride)
    uniform const float temp[], // shape: (height, stride)
    uniform int width,
    uniform int height,
    uniform int stride
) {
    const uniform int nlm_s = 0;
    uniform int start = nlm_s;
    uniform int end = width - nlm_s;

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < nlm_s; x++) {
            uniform float sum = 0.0f;
            #pragma unroll
            for (uniform int j = -nlm_s; j <= nlm_s; ++j) {
                sum += temp[y * stride + CLAMPX(x + j)];
            }
            temp0[y * stride + x] = sum;
        }

        foreach (x = start ... end) {
            float sum = 0.0f;
            #pragma unroll
            for (uniform int j = -nlm_s; j <= nlm_s; ++j) {
                sum += temp[y * stride + x + j];
            }
            temp0[y * stride + x] = sum;
        }

        for (uniform int x = end; x < width; x++) {
            uniform float sum = 0.0f;
            #pragma unroll
            for (uniform int j = -nlm_s; j <= nlm_s; ++j) {
                sum += temp[y * stride + CLAMPX(x + j)];
            }
            temp0[y * stride + x] = sum;
        }
    }
}

static void nlmHorizontalS1(
    uniform float temp0[], // shape: (height, stride)
    uniform const float temp[], // shape: (height, stride)
    uniform int width,
    uniform int height,
    uniform int stride
) {
    const uniform int nlm_s = 1;
    uniform int start = nlm_s;
    uniform int end = width - nlm_s;

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < nlm_s; x++) {
            uniform float sum = 0.0f;
            #pragma unroll
            for (uniform int j = -nlm_s; j <= nlm_s; ++j) {
                sum += temp[y * stride + CLAMPX(x + j)];
            }
            temp0[y * stride + x] = sum;
        }

        foreach (x = start ... end) {
            float sum = 0.0f;
            #pragma unroll
            for (uniform int j = -nlm_s; j <= nlm_s; ++j) {
                sum += temp[y * stride + x + j];
            }
            temp0[y * stride + x] = sum;
        }

        for (uniform int x = end; x < width; x++) {
            uniform float sum = 0.0f;
            #pragma unroll
            for (uniform int j = -nlm_s; j <= nlm_s; ++j) {
                sum += temp[y * stride + CLAMPX(x + j)];
            }
            temp0[y * stride + x] = sum;
        }
    }
}

static void nlmHorizontalS2(
    uniform float temp0[], // shape: (height, stride)
    uniform const float temp[], // shape: (height, stride)
    uniform int width,
    uniform int height,
    uniform int stride
) {

    const uniform int nlm_s = 2;
    uniform int start = nlm_s;
    uniform int end = width - nlm_s;

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < nlm_s; x++) {
            uniform float sum = 0.0f;
            #pragma unroll
            for (uniform int j = -nlm_s; j <= nlm_s; ++j) {
                sum += temp[y * stride + CLAMPX(x + j)];
            }
            temp0[y * stride + x] = sum;
        }

        foreach (x = start ... end) {
            float sum = 0.0f;
            #pragma unroll
            for (uniform int j = -nlm_s; j <= nlm_s; ++j) {
                sum += temp[y * stride + x + j];
            }
            temp0[y * stride + x] = sum;
        }

        for (uniform int x = end; x < width; x++) {
            uniform float sum = 0.0f;
            #pragma unroll
            for (uniform int j = -nlm_s; j <= nlm_s; ++j) {
                sum += temp[y * stride + CLAMPX(x + j)];
            }
            temp0[y * stride + x] = sum;
        }
    }
}

static void nlmHorizontalS3(
    uniform float temp0[], // shape: (height, stride)
    uniform const float temp[], // shape: (height, stride)
    uniform int width,
    uniform int height,
    uniform int stride
) {

    const uniform int nlm_s = 3;
    uniform int start = nlm_s;
    uniform int end = width - nlm_s;

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < nlm_s; x++) {
            uniform float sum = 0.0f;
            #pragma unroll
            for (uniform int j = -nlm_s; j <= nlm_s; ++j) {
                sum += temp[y * stride + CLAMPX(x + j)];
            }
            temp0[y * stride + x] = sum;
        }

        foreach (x = start ... end) {
            float sum = 0.0f;
            #pragma unroll
            for (uniform int j = -nlm_s; j <= nlm_s; ++j) {
                sum += temp[y * stride + x + j];
            }
            temp0[y * stride + x] = sum;
        }

        for (uniform int x = end; x < width; x++) {
            uniform float sum = 0.0f;
            #pragma unroll
            for (uniform int j = -nlm_s; j <= nlm_s; ++j) {
                sum += temp[y * stride + CLAMPX(x + j)];
            }
            temp0[y * stride + x] = sum;
        }
    }
}

static void nlmHorizontalS4(
    uniform float temp0[], // shape: (height, stride)
    uniform const float temp[], // shape: (height, stride)
    uniform int width,
    uniform int height,
    uniform int stride
) {

    const uniform int nlm_s = 4;
    uniform int start = nlm_s;
    uniform int end = width - nlm_s;

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < nlm_s; x++) {
            uniform float sum = 0.0f;
            #pragma unroll
            for (uniform int j = -nlm_s; j <= nlm_s; ++j) {
                sum += temp[y * stride + CLAMPX(x + j)];
            }
            temp0[y * stride + x] = sum;
        }

        foreach (x = start ... end) {
            float sum = 0.0f;
            #pragma unroll
            for (uniform int j = -nlm_s; j <= nlm_s; ++j) {
                sum += temp[y * stride + x + j];
            }
            temp0[y * stride + x] = sum;
        }

        for (uniform int x = end; x < width; x++) {
            uniform float sum = 0.0f;
            #pragma unroll
            for (uniform int j = -nlm_s; j <= nlm_s; ++j) {
                sum += temp[y * stride + CLAMPX(x + j)];
            }
            temp0[y * stride + x] = sum;
        }
    }
}

export void nlmHorizontal(
    uniform float temp0[], // shape: (height, stride)
    uniform const float temp[], // shape: (height, stride)
    uniform int nlm_s,
    uniform int width,
    uniform int height,
    uniform int stride
) {
    // dynamic dispatch on nlm_s
    if (nlm_s == 0) {
        nlmHorizontalS0(temp0, temp, width, height, stride);
        return ;
    } else if (nlm_s == 1) {
        nlmHorizontalS1(temp0, temp, width, height, stride);
        return ;
    } else if (nlm_s == 2) {
        nlmHorizontalS2(temp0, temp, width, height, stride);
        return ;
    } else if (nlm_s == 3) {
        nlmHorizontalS3(temp0, temp, width, height, stride);
        return ;
    } else if (nlm_s == 4) {
        nlmHorizontalS4(temp0, temp, width, height, stride);
        return ;
    }

    uniform int start = nlm_s;
    uniform int end = width - nlm_s;

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < nlm_s; x++) {
            uniform float sum = 0.0f;
            for (uniform int j = -nlm_s; j <= nlm_s; ++j) {
                sum += temp[y * stride + CLAMPX(x + j)];
            }
            temp0[y * stride + x] = sum;
        }

        foreach (x = start ... end) {
            float sum = 0.0f;
            for (uniform int j = -nlm_s; j <= nlm_s; ++j) {
                sum += temp[y * stride + x + j];
            }
            temp0[y * stride + x] = sum;
        }

        for (uniform int x = end; x < width; x++) {
            uniform float sum = 0.0f;
            for (uniform int j = -nlm_s; j <= nlm_s; ++j) {
                sum += temp[y * stride + CLAMPX(x + j)];
            }
            temp0[y * stride + x] = sum;
        }
    }
}

static inline float welsch(float sum, uniform float h2_inv_norm) {
    return exp(-sum * h2_inv_norm);
}

export void nlmVerticalWelsch(
    uniform float dstp[], // shape: (height, stride)
    uniform const float srcp[], // shape: (height, stride)
    uniform int radius,
    uniform float h2_inv_norm,
    uniform int width,
    uniform int height,
    uniform int stride,
    uniform float buffer[] // shape: (width,)
) {

    foreach (x = 0 ... width) {
        buffer[x] = radius * srcp[x];
    }

    for (uniform int y = 0; y < radius; ++y) {
        foreach (x = 0 ... width) {
            buffer[x] += srcp[min(y, height - 1) * stride + x];
        }
    }

    for (uniform int y = 0; y < min(radius, height); ++y) {
        foreach (x = 0 ... width) {
            buffer[x] += srcp[min(y + radius, height - 1) * stride + x];
            dstp[y * stride + x] = welsch(buffer[x], h2_inv_norm);
            buffer[x] -= srcp[x];
        }
    }

    if (height > radius) {
        for (uniform int y = radius; y < height - radius; ++y) {
            foreach (x = 0 ... width) {
                buffer[x] += srcp[(y + radius) * stride + x];
                dstp[y * stride + x] = welsch(buffer[x], h2_inv_norm);
                buffer[x] -= srcp[(y - radius) * stride + x];
            }
        }

        for (uniform int y = max(height - radius, radius); y < height; ++y) {
            foreach (x = 0 ... width) {
                buffer[x] += srcp[min(y + radius, height - 1) * stride + x];
                dstp[y * stride + x] = welsch(buffer[x], h2_inv_norm);
                buffer[x] -= srcp[(y - radius) * stride + x];
            }
        }
    }
}

// positive difference
static inline float fdim(uniform float x, float y) {
    return (x > y) ? x - y : 0.0f;
}

static inline float bisquareA(float sum, uniform float h2_inv_norm) {
    float tmp = fdim(1.0f, sum * h2_inv_norm);
    return tmp;
}

export void nlmVerticalBisquareA(
    uniform float dstp[], // shape: (height, stride)
    uniform const float srcp[], // shape: (height, stride)
    uniform int radius,
    uniform float h2_inv_norm,
    uniform int width,
    uniform int height,
    uniform int stride,
    uniform float buffer[] // shape: (width,)
) {

    foreach (x = 0 ... width) {
        buffer[x] = radius * srcp[x];
    }

    for (uniform int y = 0; y < radius; ++y) {
        foreach (x = 0 ... width) {
            buffer[x] += srcp[min(y, height - 1) * stride + x];
        }
    }

    for (uniform int y = 0; y < min(radius, height); ++y) {
        foreach (x = 0 ... width) {
            buffer[x] += srcp[min(y + radius, height - 1) * stride + x];
            dstp[y * stride + x] = bisquareA(buffer[x], h2_inv_norm);
            buffer[x] -= srcp[x];
        }
    }

    if (height > radius) {
        for (uniform int y = radius; y < height - radius; ++y) {
            foreach (x = 0 ... width) {
                buffer[x] += srcp[(y + radius) * stride + x];
                dstp[y * stride + x] = bisquareA(buffer[x], h2_inv_norm);
                buffer[x] -= srcp[(y - radius) * stride + x];
            }
        }

        for (uniform int y = max(height - radius, radius); y < height; ++y) {
            foreach (x = 0 ... width) {
                buffer[x] += srcp[min(y + radius, height - 1) * stride + x];
                dstp[y * stride + x] = bisquareA(buffer[x], h2_inv_norm);
                buffer[x] -= srcp[(y - radius) * stride + x];
            }
        }
    }
}

static inline float bisquareB(float sum, uniform float h2_inv_norm) {
    float tmp = fdim(1.0f, sum * h2_inv_norm);
    tmp *= tmp;
    return tmp;
}

export void nlmVerticalBisquareB(
    uniform float dstp[], // shape: (height, stride)
    uniform const float srcp[], // shape: (height, stride)
    uniform int radius,
    uniform float h2_inv_norm,
    uniform int width,
    uniform int height,
    uniform int stride,
    uniform float buffer[] // shape: (width,)
) {

    foreach (x = 0 ... width) {
        buffer[x] = radius * srcp[x];
    }

    for (uniform int y = 0; y < radius; ++y) {
        foreach (x = 0 ... width) {
            buffer[x] += srcp[min(y, height - 1) * stride + x];
        }
    }

    for (uniform int y = 0; y < min(radius, height); ++y) {
        foreach (x = 0 ... width) {
            buffer[x] += srcp[min(y + radius, height - 1) * stride + x];
            dstp[y * stride + x] = bisquareB(buffer[x], h2_inv_norm);
            buffer[x] -= srcp[x];
        }
    }

    if (height > radius) {
        for (uniform int y = radius; y < height - radius; ++y) {
            foreach (x = 0 ... width) {
                buffer[x] += srcp[(y + radius) * stride + x];
                dstp[y * stride + x] = bisquareB(buffer[x], h2_inv_norm);
                buffer[x] -= srcp[(y - radius) * stride + x];
            }
        }

        for (uniform int y = max(height - radius, radius); y < height; ++y) {
            foreach (x = 0 ... width) {
                buffer[x] += srcp[min(y + radius, height - 1) * stride + x];
                dstp[y * stride + x] = bisquareB(buffer[x], h2_inv_norm);
                buffer[x] -= srcp[(y - radius) * stride + x];
            }
        }
    }
}

static inline float bisquareC(float sum, uniform float h2_inv_norm) {
    float tmp = fdim(1.0f, sum * h2_inv_norm);
    tmp *= tmp;
    tmp *= tmp;
    tmp *= tmp;
    return tmp;
}

export void nlmVerticalBisquareC(
    uniform float dstp[], // shape: (height, stride)
    uniform const float srcp[], // shape: (height, stride)
    uniform int radius,
    uniform float h2_inv_norm,
    uniform int width,
    uniform int height,
    uniform int stride,
    uniform float buffer[] // shape: (width,)
) {

    foreach (x = 0 ... width) {
        buffer[x] = radius * srcp[x];
    }

    for (uniform int y = 0; y < radius; ++y) {
        foreach (x = 0 ... width) {
            buffer[x] += srcp[min(y, height - 1) * stride + x];
        }
    }

    for (uniform int y = 0; y < min(radius, height); ++y) {
        foreach (x = 0 ... width) {
            buffer[x] += srcp[min(y + radius, height - 1) * stride + x];
            dstp[y * stride + x] = bisquareC(buffer[x], h2_inv_norm);
            buffer[x] -= srcp[x];
        }
    }

    if (height > radius) {
        for (uniform int y = radius; y < height - radius; ++y) {
            foreach (x = 0 ... width) {
                buffer[x] += srcp[(y + radius) * stride + x];
                dstp[y * stride + x] = bisquareC(buffer[x], h2_inv_norm);
                buffer[x] -= srcp[(y - radius) * stride + x];
            }
        }

        for (uniform int y = max(height - radius, radius); y < height; ++y) {
            foreach (x = 0 ... width) {
                buffer[x] += srcp[min(y + radius, height - 1) * stride + x];
                dstp[y * stride + x] = bisquareC(buffer[x], h2_inv_norm);
                buffer[x] -= srcp[(y - radius) * stride + x];
            }
        }
    }
}

export void nlmAccumulationCh1_f32(
    uniform float weightp[], // shape: (height, stride)
    uniform float wdstp[], // shape: (height, stride)
    uniform float max_weightp[], // shape: (height, stride)
    uniform const float srcp_bwd[], // shape: (height, stride)
    uniform const float srcp_fwd[], // shape: (height, stride)
    uniform const float temp1[], // shape: (height, stride)
    uniform const float temp2[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;

            uniform float u4 = temp1[idx];
            uniform float u4_mq = temp2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            uniform float u1_pq = srcp_bwd[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];

            uniform float u1_mq = srcp_fwd[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            wdstp[idx] += u4 * u1_pq + u4_mq * u1_mq;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;

            float u4 = temp1[idx];
            float u4_mq = temp2[CLAMPY(y - offset_y) * stride + (x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            float u1_pq = srcp_bwd[CLAMPY(y + offset_y) * stride + (x + offset_x)];

            float u1_mq = srcp_fwd[CLAMPY(y - offset_y) * stride + (x - offset_x)];

            wdstp[idx] += u4 * u1_pq + u4_mq * u1_mq;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;

            uniform float u4 = temp1[idx];
            uniform float u4_mq = temp2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            uniform float u1_pq = srcp_bwd[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];

            uniform float u1_mq = srcp_fwd[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            wdstp[idx] += u4 * u1_pq + u4_mq * u1_mq;
        }
    }
}

export void nlmAccumulationCh1_u8(
    uniform float weightp[], // shape: (height, stride)
    uniform float wdstp[], // shape: (height, stride)
    uniform float max_weightp[], // shape: (height, stride)
    uniform const unsigned int8 srcp_bwd[], // shape: (height, stride)
    uniform const unsigned int8 srcp_fwd[], // shape: (height, stride)
    uniform const float temp1[], // shape: (height, stride)
    uniform const float temp2[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;

            uniform float u4 = temp1[idx];
            uniform float u4_mq = temp2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            uniform float u1_pq = srcp_bwd[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];

            uniform float u1_mq = srcp_fwd[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            wdstp[idx] += u4 * u1_pq + u4_mq * u1_mq;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;

            float u4 = temp1[idx];
            float u4_mq = temp2[CLAMPY(y - offset_y) * stride + (x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            float u1_pq = srcp_bwd[CLAMPY(y + offset_y) * stride + (x + offset_x)];

            float u1_mq = srcp_fwd[CLAMPY(y - offset_y) * stride + (x - offset_x)];

            wdstp[idx] += u4 * u1_pq + u4_mq * u1_mq;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;

            uniform float u4 = temp1[idx];
            uniform float u4_mq = temp2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            uniform float u1_pq = srcp_bwd[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];

            uniform float u1_mq = srcp_fwd[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            wdstp[idx] += u4 * u1_pq + u4_mq * u1_mq;
        }
    }
}

export void nlmAccumulationCh1_u16(
    uniform float weightp[], // shape: (height, stride)
    uniform float wdstp[], // shape: (height, stride)
    uniform float max_weightp[], // shape: (height, stride)
    uniform const unsigned int16 srcp_bwd[], // shape: (height, stride)
    uniform const unsigned int16 srcp_fwd[], // shape: (height, stride)
    uniform const float temp1[], // shape: (height, stride)
    uniform const float temp2[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;

            uniform float u4 = temp1[idx];
            uniform float u4_mq = temp2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            uniform float u1_pq = srcp_bwd[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];

            uniform float u1_mq = srcp_fwd[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            wdstp[idx] += u4 * u1_pq + u4_mq * u1_mq;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;

            float u4 = temp1[idx];
            float u4_mq = temp2[CLAMPY(y - offset_y) * stride + (x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            float u1_pq = srcp_bwd[CLAMPY(y + offset_y) * stride + (x + offset_x)];

            float u1_mq = srcp_fwd[CLAMPY(y - offset_y) * stride + (x - offset_x)];

            wdstp[idx] += u4 * u1_pq + u4_mq * u1_mq;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;

            uniform float u4 = temp1[idx];
            uniform float u4_mq = temp2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            uniform float u1_pq = srcp_bwd[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];

            uniform float u1_mq = srcp_fwd[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            wdstp[idx] += u4 * u1_pq + u4_mq * u1_mq;
        }
    }
}

export void nlmAccumulationCh2_f32(
    uniform float weightp[], // shape: (height, stride)
    uniform float wdstp1[], // shape: (height, stride)
    uniform float wdstp2[], // shape: (height, stride)
    uniform float max_weightp[], // shape: (height, stride)
    uniform const float srcp_bwd1[], // shape: (height, stride)
    uniform const float srcp_bwd2[], // shape: (height, stride)
    uniform const float srcp_fwd1[], // shape: (height, stride)
    uniform const float srcp_fwd2[], // shape: (height, stride)
    uniform const float temp1[], // shape: (height, stride)
    uniform const float temp2[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;

            uniform float u4 = temp1[idx];
            uniform float u4_mq = temp2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            uniform float u1_pq_1 = srcp_bwd1[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];
            uniform float u1_pq_2 = srcp_bwd2[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];

            uniform float u1_mq_2 = srcp_fwd2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];
            uniform float u1_mq_1 = srcp_fwd1[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            wdstp1[idx] += u4 * u1_pq_1 + u4_mq * u1_mq_1;
            wdstp2[idx] += u4 * u1_pq_2 + u4_mq * u1_mq_2;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;

            float u4 = temp1[idx];
            float u4_mq = temp2[CLAMPY(y - offset_y) * stride + (x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            float u1_pq_1 = srcp_bwd1[CLAMPY(y + offset_y) * stride + (x + offset_x)];
            float u1_pq_2 = srcp_bwd2[CLAMPY(y + offset_y) * stride + (x + offset_x)];
            float u1_mq_1 = srcp_fwd1[CLAMPY(y - offset_y) * stride + (x - offset_x)];
            float u1_mq_2 = srcp_fwd2[CLAMPY(y - offset_y) * stride + (x - offset_x)];

            wdstp1[idx] += u4 * u1_pq_1 + u4_mq * u1_mq_1;
            wdstp2[idx] += u4 * u1_pq_2 + u4_mq * u1_mq_2;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;

            uniform float u4 = temp1[idx];
            uniform float u4_mq = temp2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            uniform float u1_pq_1 = srcp_bwd1[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];
            uniform float u1_pq_2 = srcp_bwd2[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];

            uniform float u1_mq_1 = srcp_fwd1[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];
            uniform float u1_mq_2 = srcp_fwd2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            wdstp1[idx] += u4 * u1_pq_1 + u4_mq * u1_mq_1;
            wdstp2[idx] += u4 * u1_pq_2 + u4_mq * u1_mq_2;
        }
    }
}

export void nlmAccumulationCh2_u8(
    uniform float weightp[], // shape: (height, stride)
    uniform float wdstp1[], // shape: (height, stride)
    uniform float wdstp2[], // shape: (height, stride)
    uniform float max_weightp[], // shape: (height, stride)
    uniform const unsigned int8 srcp_bwd1[], // shape: (height, stride)
    uniform const unsigned int8 srcp_bwd2[], // shape: (height, stride)
    uniform const unsigned int8 srcp_fwd1[], // shape: (height, stride)
    uniform const unsigned int8 srcp_fwd2[], // shape: (height, stride)
    uniform const float temp1[], // shape: (height, stride)
    uniform const float temp2[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;

            uniform float u4 = temp1[idx];
            uniform float u4_mq = temp2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            uniform float u1_pq_1 = srcp_bwd1[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];
            uniform float u1_pq_2 = srcp_bwd2[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];

            uniform float u1_mq_2 = srcp_fwd2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];
            uniform float u1_mq_1 = srcp_fwd1[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            wdstp1[idx] += u4 * u1_pq_1 + u4_mq * u1_mq_1;
            wdstp2[idx] += u4 * u1_pq_2 + u4_mq * u1_mq_2;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;

            float u4 = temp1[idx];
            float u4_mq = temp2[CLAMPY(y - offset_y) * stride + (x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            float u1_pq_1 = srcp_bwd1[CLAMPY(y + offset_y) * stride + (x + offset_x)];
            float u1_pq_2 = srcp_bwd2[CLAMPY(y + offset_y) * stride + (x + offset_x)];
            float u1_mq_1 = srcp_fwd1[CLAMPY(y - offset_y) * stride + (x - offset_x)];
            float u1_mq_2 = srcp_fwd2[CLAMPY(y - offset_y) * stride + (x - offset_x)];

            wdstp1[idx] += u4 * u1_pq_1 + u4_mq * u1_mq_1;
            wdstp2[idx] += u4 * u1_pq_2 + u4_mq * u1_mq_2;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;

            uniform float u4 = temp1[idx];
            uniform float u4_mq = temp2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            uniform float u1_pq_1 = srcp_bwd1[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];
            uniform float u1_pq_2 = srcp_bwd2[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];

            uniform float u1_mq_1 = srcp_fwd1[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];
            uniform float u1_mq_2 = srcp_fwd2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            wdstp1[idx] += u4 * u1_pq_1 + u4_mq * u1_mq_1;
            wdstp2[idx] += u4 * u1_pq_2 + u4_mq * u1_mq_2;
        }
    }
}

export void nlmAccumulationCh2_u16(
    uniform float weightp[], // shape: (height, stride)
    uniform float wdstp1[], // shape: (height, stride)
    uniform float wdstp2[], // shape: (height, stride)
    uniform float max_weightp[], // shape: (height, stride)
    uniform const unsigned int16 srcp_bwd1[], // shape: (height, stride)
    uniform const unsigned int16 srcp_bwd2[], // shape: (height, stride)
    uniform const unsigned int16 srcp_fwd1[], // shape: (height, stride)
    uniform const unsigned int16 srcp_fwd2[], // shape: (height, stride)
    uniform const float temp1[], // shape: (height, stride)
    uniform const float temp2[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;

            uniform float u4 = temp1[idx];
            uniform float u4_mq = temp2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            uniform float u1_pq_1 = srcp_bwd1[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];
            uniform float u1_pq_2 = srcp_bwd2[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];

            uniform float u1_mq_2 = srcp_fwd2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];
            uniform float u1_mq_1 = srcp_fwd1[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            wdstp1[idx] += u4 * u1_pq_1 + u4_mq * u1_mq_1;
            wdstp2[idx] += u4 * u1_pq_2 + u4_mq * u1_mq_2;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;

            float u4 = temp1[idx];
            float u4_mq = temp2[CLAMPY(y - offset_y) * stride + (x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            float u1_pq_1 = srcp_bwd1[CLAMPY(y + offset_y) * stride + (x + offset_x)];
            float u1_pq_2 = srcp_bwd2[CLAMPY(y + offset_y) * stride + (x + offset_x)];
            float u1_mq_1 = srcp_fwd1[CLAMPY(y - offset_y) * stride + (x - offset_x)];
            float u1_mq_2 = srcp_fwd2[CLAMPY(y - offset_y) * stride + (x - offset_x)];

            wdstp1[idx] += u4 * u1_pq_1 + u4_mq * u1_mq_1;
            wdstp2[idx] += u4 * u1_pq_2 + u4_mq * u1_mq_2;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;

            uniform float u4 = temp1[idx];
            uniform float u4_mq = temp2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            uniform float u1_pq_1 = srcp_bwd1[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];
            uniform float u1_pq_2 = srcp_bwd2[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];

            uniform float u1_mq_1 = srcp_fwd1[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];
            uniform float u1_mq_2 = srcp_fwd2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            wdstp1[idx] += u4 * u1_pq_1 + u4_mq * u1_mq_1;
            wdstp2[idx] += u4 * u1_pq_2 + u4_mq * u1_mq_2;
        }
    }
}

export void nlmAccumulationCh3_f32(
    uniform float weightp[], // shape: (height, stride)
    uniform float wdstp1[], // shape: (height, stride)
    uniform float wdstp2[], // shape: (height, stride)
    uniform float wdstp3[], // shape: (height, stride)
    uniform float max_weightp[], // shape: (height, stride)
    uniform const float srcp_bwd1[], // shape: (height, stride)
    uniform const float srcp_bwd2[], // shape: (height, stride)
    uniform const float srcp_bwd3[], // shape: (height, stride)
    uniform const float srcp_fwd1[], // shape: (height, stride)
    uniform const float srcp_fwd2[], // shape: (height, stride)
    uniform const float srcp_fwd3[], // shape: (height, stride)
    uniform const float temp1[], // shape: (height, stride)
    uniform const float temp2[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;

            uniform float u4 = temp1[idx];
            uniform float u4_mq = temp2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            uniform float u1_pq_1 = srcp_bwd1[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];
            uniform float u1_pq_2 = srcp_bwd2[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];
            uniform float u1_pq_3 = srcp_bwd3[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];

            uniform float u1_mq_2 = srcp_fwd2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];
            uniform float u1_mq_1 = srcp_fwd1[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];
            uniform float u1_mq_3 = srcp_fwd3[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            wdstp1[idx] += u4 * u1_pq_1 + u4_mq * u1_mq_1;
            wdstp2[idx] += u4 * u1_pq_2 + u4_mq * u1_mq_2;
            wdstp3[idx] += u4 * u1_pq_3 + u4_mq * u1_mq_3;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;

            float u4 = temp1[idx];
            float u4_mq = temp2[CLAMPY(y - offset_y) * stride + (x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            float u1_pq_1 = srcp_bwd1[CLAMPY(y + offset_y) * stride + (x + offset_x)];
            float u1_pq_2 = srcp_bwd2[CLAMPY(y + offset_y) * stride + (x + offset_x)];
            float u1_pq_3 = srcp_bwd3[CLAMPY(y + offset_y) * stride + (x + offset_x)];

            float u1_mq_1 = srcp_fwd1[CLAMPY(y - offset_y) * stride + (x - offset_x)];
            float u1_mq_2 = srcp_fwd2[CLAMPY(y - offset_y) * stride + (x - offset_x)];
            float u1_mq_3 = srcp_fwd3[CLAMPY(y - offset_y) * stride + (x - offset_x)];

            wdstp1[idx] += u4 * u1_pq_1 + u4_mq * u1_mq_1;
            wdstp2[idx] += u4 * u1_pq_2 + u4_mq * u1_mq_2;
            wdstp3[idx] += u4 * u1_pq_3 + u4_mq * u1_mq_3;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;

            uniform float u4 = temp1[idx];
            uniform float u4_mq = temp2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            uniform float u1_pq_1 = srcp_bwd1[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];
            uniform float u1_pq_2 = srcp_bwd2[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];
            uniform float u1_pq_3 = srcp_bwd3[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];

            uniform float u1_mq_1 = srcp_fwd1[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];
            uniform float u1_mq_2 = srcp_fwd2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];
            uniform float u1_mq_3 = srcp_fwd3[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            wdstp1[idx] += u4 * u1_pq_1 + u4_mq * u1_mq_1;
            wdstp2[idx] += u4 * u1_pq_2 + u4_mq * u1_mq_2;
            wdstp3[idx] += u4 * u1_pq_3 + u4_mq * u1_mq_3;
        }
    }
}

export void nlmAccumulationCh3_u8(
    uniform float weightp[], // shape: (height, stride)
    uniform float wdstp1[], // shape: (height, stride)
    uniform float wdstp2[], // shape: (height, stride)
    uniform float wdstp3[], // shape: (height, stride)
    uniform float max_weightp[], // shape: (height, stride)
    uniform const unsigned int8 srcp_bwd1[], // shape: (height, stride)
    uniform const unsigned int8 srcp_bwd2[], // shape: (height, stride)
    uniform const unsigned int8 srcp_bwd3[], // shape: (height, stride)
    uniform const unsigned int8 srcp_fwd1[], // shape: (height, stride)
    uniform const unsigned int8 srcp_fwd2[], // shape: (height, stride)
    uniform const unsigned int8 srcp_fwd3[], // shape: (height, stride)
    uniform const float temp1[], // shape: (height, stride)
    uniform const float temp2[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;

            uniform float u4 = temp1[idx];
            uniform float u4_mq = temp2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            uniform float u1_pq_1 = srcp_bwd1[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];
            uniform float u1_pq_2 = srcp_bwd2[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];
            uniform float u1_pq_3 = srcp_bwd3[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];

            uniform float u1_mq_2 = srcp_fwd2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];
            uniform float u1_mq_1 = srcp_fwd1[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];
            uniform float u1_mq_3 = srcp_fwd3[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            wdstp1[idx] += u4 * u1_pq_1 + u4_mq * u1_mq_1;
            wdstp2[idx] += u4 * u1_pq_2 + u4_mq * u1_mq_2;
            wdstp3[idx] += u4 * u1_pq_3 + u4_mq * u1_mq_3;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;

            float u4 = temp1[idx];
            float u4_mq = temp2[CLAMPY(y - offset_y) * stride + (x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            float u1_pq_1 = srcp_bwd1[CLAMPY(y + offset_y) * stride + (x + offset_x)];
            float u1_pq_2 = srcp_bwd2[CLAMPY(y + offset_y) * stride + (x + offset_x)];
            float u1_pq_3 = srcp_bwd3[CLAMPY(y + offset_y) * stride + (x + offset_x)];

            float u1_mq_1 = srcp_fwd1[CLAMPY(y - offset_y) * stride + (x - offset_x)];
            float u1_mq_2 = srcp_fwd2[CLAMPY(y - offset_y) * stride + (x - offset_x)];
            float u1_mq_3 = srcp_fwd3[CLAMPY(y - offset_y) * stride + (x - offset_x)];

            wdstp1[idx] += u4 * u1_pq_1 + u4_mq * u1_mq_1;
            wdstp2[idx] += u4 * u1_pq_2 + u4_mq * u1_mq_2;
            wdstp3[idx] += u4 * u1_pq_3 + u4_mq * u1_mq_3;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;

            uniform float u4 = temp1[idx];
            uniform float u4_mq = temp2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            uniform float u1_pq_1 = srcp_bwd1[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];
            uniform float u1_pq_2 = srcp_bwd2[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];
            uniform float u1_pq_3 = srcp_bwd3[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];

            uniform float u1_mq_1 = srcp_fwd1[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];
            uniform float u1_mq_2 = srcp_fwd2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];
            uniform float u1_mq_3 = srcp_fwd3[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            wdstp1[idx] += u4 * u1_pq_1 + u4_mq * u1_mq_1;
            wdstp2[idx] += u4 * u1_pq_2 + u4_mq * u1_mq_2;
            wdstp3[idx] += u4 * u1_pq_3 + u4_mq * u1_mq_3;
        }
    }
}

export void nlmAccumulationCh3_u16(
    uniform float weightp[], // shape: (height, stride)
    uniform float wdstp1[], // shape: (height, stride)
    uniform float wdstp2[], // shape: (height, stride)
    uniform float wdstp3[], // shape: (height, stride)
    uniform float max_weightp[], // shape: (height, stride)
    uniform const unsigned int16 srcp_bwd1[], // shape: (height, stride)
    uniform const unsigned int16 srcp_bwd2[], // shape: (height, stride)
    uniform const unsigned int16 srcp_bwd3[], // shape: (height, stride)
    uniform const unsigned int16 srcp_fwd1[], // shape: (height, stride)
    uniform const unsigned int16 srcp_fwd2[], // shape: (height, stride)
    uniform const unsigned int16 srcp_fwd3[], // shape: (height, stride)
    uniform const float temp1[], // shape: (height, stride)
    uniform const float temp2[], // shape: (height, stride)
    uniform int offset_x,
    uniform int offset_y,
    uniform int width,
    uniform int height,
    uniform int stride
) {

    uniform int start_x = abs(offset_x);
    uniform int end_x = width - abs(offset_x);

    for (uniform int y = 0; y < height; y++) {
        for (uniform int x = 0; x < start_x; x++) {
            uniform int idx = y * stride + x;

            uniform float u4 = temp1[idx];
            uniform float u4_mq = temp2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            uniform float u1_pq_1 = srcp_bwd1[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];
            uniform float u1_pq_2 = srcp_bwd2[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];
            uniform float u1_pq_3 = srcp_bwd3[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];

            uniform float u1_mq_2 = srcp_fwd2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];
            uniform float u1_mq_1 = srcp_fwd1[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];
            uniform float u1_mq_3 = srcp_fwd3[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            wdstp1[idx] += u4 * u1_pq_1 + u4_mq * u1_mq_1;
            wdstp2[idx] += u4 * u1_pq_2 + u4_mq * u1_mq_2;
            wdstp3[idx] += u4 * u1_pq_3 + u4_mq * u1_mq_3;
        }

        foreach (x = start_x ... end_x) {
            int idx = y * stride + x;

            float u4 = temp1[idx];
            float u4_mq = temp2[CLAMPY(y - offset_y) * stride + (x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            float u1_pq_1 = srcp_bwd1[CLAMPY(y + offset_y) * stride + (x + offset_x)];
            float u1_pq_2 = srcp_bwd2[CLAMPY(y + offset_y) * stride + (x + offset_x)];
            float u1_pq_3 = srcp_bwd3[CLAMPY(y + offset_y) * stride + (x + offset_x)];

            float u1_mq_1 = srcp_fwd1[CLAMPY(y - offset_y) * stride + (x - offset_x)];
            float u1_mq_2 = srcp_fwd2[CLAMPY(y - offset_y) * stride + (x - offset_x)];
            float u1_mq_3 = srcp_fwd3[CLAMPY(y - offset_y) * stride + (x - offset_x)];

            wdstp1[idx] += u4 * u1_pq_1 + u4_mq * u1_mq_1;
            wdstp2[idx] += u4 * u1_pq_2 + u4_mq * u1_mq_2;
            wdstp3[idx] += u4 * u1_pq_3 + u4_mq * u1_mq_3;
        }

        for (uniform int x = end_x; x < width; x++) {
            uniform int idx = y * stride + x;

            uniform float u4 = temp1[idx];
            uniform float u4_mq = temp2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            weightp[idx] += u4 + u4_mq;
            max_weightp[idx] = max(max(u4, u4_mq), max_weightp[idx]);

            uniform float u1_pq_1 = srcp_bwd1[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];
            uniform float u1_pq_2 = srcp_bwd2[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];
            uniform float u1_pq_3 = srcp_bwd3[CLAMPY(y + offset_y) * stride + CLAMPX(x + offset_x)];

            uniform float u1_mq_1 = srcp_fwd1[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];
            uniform float u1_mq_2 = srcp_fwd2[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];
            uniform float u1_mq_3 = srcp_fwd3[CLAMPY(y - offset_y) * stride + CLAMPX(x - offset_x)];

            wdstp1[idx] += u4 * u1_pq_1 + u4_mq * u1_mq_1;
            wdstp2[idx] += u4 * u1_pq_2 + u4_mq * u1_mq_2;
            wdstp3[idx] += u4 * u1_pq_3 + u4_mq * u1_mq_3;
        }
    }
}

export void nlmFinishCh1_f32(
    uniform float dstp[], // shape: (height, stride)
    uniform const float srcp[], // shape: (height, stride)
    uniform const float weightp[], // shape: (height, stride)
    uniform const float wdstp[], // shape: (height, stride)
    uniform const float max_weightp[], // shape: (height, stride) // epsilon
    uniform float wref,
    uniform int width,
    uniform int height,
    uniform int stride
) {

    foreach (y = 0 ... height, x = 0 ... width) {
        int idx = y * stride + x;

        float multiplier = wref * max_weightp[idx];

        float denominator = multiplier + weightp[idx];

        dstp[idx] = (multiplier * srcp[idx] + wdstp[idx]) / denominator;
    }
}

export void nlmFinishCh1_u8(
    uniform unsigned int8 dstp[], // shape: (height, stride)
    uniform const unsigned int8 srcp[], // shape: (height, stride)
    uniform const float weightp[], // shape: (height, stride)
    uniform const float wdstp[], // shape: (height, stride)
    uniform const float max_weightp[], // shape: (height, stride) // epsilon
    uniform float wref,
    uniform int width,
    uniform int height,
    uniform int stride,
    uniform int peak
) {

    foreach (y = 0 ... height, x = 0 ... width) {
        int idx = y * stride + x;

        float multiplier = wref * max_weightp[idx];

        float denominator = multiplier + weightp[idx];

        dstp[idx] = max(0, min((int) round((multiplier * srcp[idx] + wdstp[idx]) / denominator), peak));
    }
}

export void nlmFinishCh1_u16(
    uniform unsigned int16 dstp[], // shape: (height, stride)
    uniform const unsigned int16 srcp[], // shape: (height, stride)
    uniform const float weightp[], // shape: (height, stride)
    uniform const float wdstp[], // shape: (height, stride)
    uniform const float max_weightp[], // shape: (height, stride) // epsilon
    uniform float wref,
    uniform int width,
    uniform int height,
    uniform int stride,
    uniform int peak
) {

    foreach (y = 0 ... height, x = 0 ... width) {
        int idx = y * stride + x;

        float multiplier = wref * max_weightp[idx];

        float denominator = multiplier + weightp[idx];

        dstp[idx] = max(0, min((int) round((multiplier * srcp[idx] + wdstp[idx]) / denominator), peak));
    }
}

export void nlmFinishCh2_f32(
    uniform float dstp1[], // shape: (height, stride)
    uniform float dstp2[], // shape: (height, stride)
    uniform const float srcp1[], // shape: (height, stride)
    uniform const float srcp2[], // shape: (height, stride)
    uniform const float weightp[], // shape: (height, stride)
    uniform const float wdstp1[], // shape: (height, stride)
    uniform const float wdstp2[], // shape: (height, stride)
    uniform const float max_weightp[], // shape: (height, stride)
    uniform float wref,
    uniform int width,
    uniform int height,
    uniform int stride
) {

    foreach (y = 0 ... height, x = 0 ... width) {
        int idx = y * stride + x;

        float multiplier = wref * max_weightp[idx];

        float denominator = multiplier + weightp[idx];

        dstp1[idx] = (multiplier * srcp1[idx] + wdstp1[idx]) / denominator;
        dstp2[idx] = (multiplier * srcp2[idx] + wdstp2[idx]) / denominator;
    }
}

export void nlmFinishCh2_u8(
    uniform unsigned int8 dstp1[], // shape: (height, stride)
    uniform unsigned int8 dstp2[], // shape: (height, stride)
    uniform const unsigned int8 srcp1[], // shape: (height, stride)
    uniform const unsigned int8 srcp2[], // shape: (height, stride)
    uniform const float weightp[], // shape: (height, stride)
    uniform const float wdstp1[], // shape: (height, stride)
    uniform const float wdstp2[], // shape: (height, stride)
    uniform const float max_weightp[], // shape: (height, stride)
    uniform float wref,
    uniform int width,
    uniform int height,
    uniform int stride,
    uniform int peak
) {

    foreach (y = 0 ... height, x = 0 ... width) {
        int idx = y * stride + x;

        float multiplier = wref * max_weightp[idx];

        float denominator = multiplier + weightp[idx];

        dstp1[idx] = max(0, min((int) round((multiplier * srcp1[idx] + wdstp1[idx]) / denominator), peak));
        dstp2[idx] = max(0, min((int) round((multiplier * srcp2[idx] + wdstp2[idx]) / denominator), peak));
    }
}

export void nlmFinishCh2_u16(
    uniform unsigned int16 dstp1[], // shape: (height, stride)
    uniform unsigned int16 dstp2[], // shape: (height, stride)
    uniform const unsigned int16 srcp1[], // shape: (height, stride)
    uniform const unsigned int16 srcp2[], // shape: (height, stride)
    uniform const float weightp[], // shape: (height, stride)
    uniform const float wdstp1[], // shape: (height, stride)
    uniform const float wdstp2[], // shape: (height, stride)
    uniform const float max_weightp[], // shape: (height, stride)
    uniform float wref,
    uniform int width,
    uniform int height,
    uniform int stride,
    uniform int peak
) {

    foreach (y = 0 ... height, x = 0 ... width) {
        int idx = y * stride + x;

        float multiplier = wref * max_weightp[idx];

        float denominator = multiplier + weightp[idx];

        dstp1[idx] = max(0, min((int) round((multiplier * srcp1[idx] + wdstp1[idx]) / denominator), peak));
        dstp2[idx] = max(0, min((int) round((multiplier * srcp2[idx] + wdstp2[idx]) / denominator), peak));
    }
}

export void nlmFinishCh3_f32(
    uniform float dstp1[], // shape: (height, stride)
    uniform float dstp2[], // shape: (height, stride)
    uniform float dstp3[], // shape: (height, stride)
    uniform const float srcp1[], // shape: (height, stride)
    uniform const float srcp2[], // shape: (height, stride)
    uniform const float srcp3[], // shape: (height, stride)
    uniform const float weightp[], // shape: (height, stride)
    uniform const float wdstp1[], // shape: (height, stride)
    uniform const float wdstp2[], // shape: (height, stride)
    uniform const float wdstp3[], // shape: (height, stride)
    uniform const float max_weightp[], // shape: (height, stride)
    uniform float wref,
    uniform int width,
    uniform int height,
    uniform int stride
) {

    foreach (y = 0 ... height, x = 0 ... width) {
        int idx = y * stride + x;

        float multiplier = wref * max_weightp[idx];

        float denominator = multiplier + weightp[idx];

        dstp1[idx] = (multiplier * srcp1[idx] + wdstp1[idx]) / denominator;
        dstp2[idx] = (multiplier * srcp2[idx] + wdstp2[idx]) / denominator;
        dstp3[idx] = (multiplier * srcp3[idx] + wdstp3[idx]) / denominator;
    }
}

export void nlmFinishCh3_u8(
    uniform unsigned int8 dstp1[], // shape: (height, stride)
    uniform unsigned int8 dstp2[], // shape: (height, stride)
    uniform unsigned int8 dstp3[], // shape: (height, stride)
    uniform const unsigned int8 srcp1[], // shape: (height, stride)
    uniform const unsigned int8 srcp2[], // shape: (height, stride)
    uniform const unsigned int8 srcp3[], // shape: (height, stride)
    uniform const float weightp[], // shape: (height, stride)
    uniform const float wdstp1[], // shape: (height, stride)
    uniform const float wdstp2[], // shape: (height, stride)
    uniform const float wdstp3[], // shape: (height, stride)
    uniform const float max_weightp[], // shape: (height, stride)
    uniform float wref,
    uniform int width,
    uniform int height,
    uniform int stride,
    uniform int peak
) {

    foreach (y = 0 ... height, x = 0 ... width) {
        int idx = y * stride + x;

        float multiplier = wref * max_weightp[idx];

        float denominator = multiplier + weightp[idx];

        dstp1[idx] = max(0, min((int) round((multiplier * srcp1[idx] + wdstp1[idx]) / denominator), peak));
        dstp2[idx] = max(0, min((int) round((multiplier * srcp2[idx] + wdstp2[idx]) / denominator), peak));
        dstp3[idx] = max(0, min((int) round((multiplier * srcp3[idx] + wdstp3[idx]) / denominator), peak));
    }
}

export void nlmFinishCh3_u16(
    uniform unsigned int16 dstp1[], // shape: (height, stride)
    uniform unsigned int16 dstp2[], // shape: (height, stride)
    uniform unsigned int16 dstp3[], // shape: (height, stride)
    uniform const unsigned int16 srcp1[], // shape: (height, stride)
    uniform const unsigned int16 srcp2[], // shape: (height, stride)
    uniform const unsigned int16 srcp3[], // shape: (height, stride)
    uniform const float weightp[], // shape: (height, stride)
    uniform const float wdstp1[], // shape: (height, stride)
    uniform const float wdstp2[], // shape: (height, stride)
    uniform const float wdstp3[], // shape: (height, stride)
    uniform const float max_weightp[], // shape: (height, stride)
    uniform float wref,
    uniform int width,
    uniform int height,
    uniform int stride,
    uniform int peak
) {

    foreach (y = 0 ... height, x = 0 ... width) {
        int idx = y * stride + x;

        float multiplier = wref * max_weightp[idx];

        float denominator = multiplier + weightp[idx];

        dstp1[idx] = max(0, min((int) round((multiplier * srcp1[idx] + wdstp1[idx]) / denominator), peak));
        dstp2[idx] = max(0, min((int) round((multiplier * srcp2[idx] + wdstp2[idx]) / denominator), peak));
        dstp3[idx] = max(0, min((int) round((multiplier * srcp3[idx] + wdstp3[idx]) / denominator), peak));
    }
}
