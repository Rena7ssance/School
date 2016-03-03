#!/usr/bin/expect

set timeout 30

expect_after {
    timeout {
        puts "----> timeout <----\r"
        exit
    }
}

spawn qemu-system-x86_64 -nographic --serial mon:stdio -hdc kernel/kernel.img -hdd fat439/user.img

expect "shell> "
send "ls\r"

expect "shell> "
send "ls -1\r"

expect "shell> "
send "ls -r\r"

expect "shell> "
send "ls -a\r"

expect "shell> "
send "ls -1 -r\r"

expect "shell> "
send "shutdown\r"

expect "*** System Shutdown ***\r"
send \001
send "x"
