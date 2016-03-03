#!/usr/bin/expect

set timeout 30

expect_after {
    timeout {
        puts "----> timeout <----\r"
        exit
    }
}

spawn qemu-system-x86_64 -nographic --serial mon:stdio -hdc kernel/kernel.img

expect "*** System Shutdown ***\r"

send \001
send "x"
