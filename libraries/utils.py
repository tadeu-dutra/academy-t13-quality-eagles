import random
import string

def clean_value(param):
    return param.replace('.', '').replace('-', '').replace(' ', '').replace('/', '')

def get_random_digit_number(length):
    # Generate a random 14-digit number
    return ''.join(random.choices('0123456789', k=length))

def generate_random_string(length):
    try:
        # Ensure the length is converted to an integer
        length = int(length)
    except ValueError:
        raise ValueError("Length must be an integer or a string that can be converted to an integer.")
    
    characters = string.ascii_letters + string.digits
    result = ''.join(random.choice(characters) for _ in range(length))
    return result