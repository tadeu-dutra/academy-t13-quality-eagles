from utils import clean_value
from faker import Faker
faker = Faker('pt_BR')

def get_fake_person():
    person = {
        "name": clean_value(faker.name()),
        "email": faker.email(),
        "cpf": clean_value(faker.cpf())
    }
    return person
