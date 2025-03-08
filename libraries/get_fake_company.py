from utils import clean_value
from utils import get_random_digit_number
from faker import Faker
faker = Faker('pt_BR')

def get_fake_address():
    address = [
        {
            "zipCode": clean_value(faker.postcode()),
            "city": faker.city(),
            "state": faker.state_abbr(),
            "district": faker.street_prefix(),
            "street": faker.street_name(),
            "number": faker.building_number(),
            "complement": faker.neighborhood(),
            "country": faker.country()
        }
    ]
    return address

def get_fake_company():
    address = get_fake_address()
    company = {
        "corporateName": faker.company(),
        "registerCompany": clean_value(faker.cnpj()),
        "mail": faker.email(),
        "matriz": faker.last_name() + " Co.",
        "responsibleContact": faker.name(),
        "telephone": get_random_digit_number(14),
        "serviceDescription": faker.text(),
        "address": address
    }
    return company
