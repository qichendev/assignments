package org.qichen.c0944666.service;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class HitCounterServiceTest {
    @Test
    void recordsPageHits() {
        HitCounterService service = new HitCounterService();

        service.recordPageHit();
        service.recordPageHit();

        assertThat(service.getHits()).isEqualTo(2);
    }
}
