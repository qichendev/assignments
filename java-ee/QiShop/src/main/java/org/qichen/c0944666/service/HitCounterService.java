package org.qichen.c0944666.service;

import org.springframework.stereotype.Service;

import java.util.concurrent.atomic.AtomicLong;

@Service
public class HitCounterService {
    private final AtomicLong hits = new AtomicLong();

    public long recordPageHit() {
        return hits.incrementAndGet();
    }

    public long getHits() {
        return hits.get();
    }
}
