#!/usr/bin/env python3

# Jake Wheeler 3/3/2019
# Generates SHA512 password hash given plaintext string

def generate_hash(plaintext):
	import random, string, crypt
	salt = ''.join(random.sample(string.ascii_letters,8))
	pw_hash = crypt.crypt(plaintext, '$6$%s$' % salt )
	return pw_hash
