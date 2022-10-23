from cgitb import html
from random import choice

from post_office import mail

def generate_code():
    seeds = "1234567890"
    random_str = []
    for i in range(6):
        random_str.append(choice(seeds))
    return "".join(random_str)


def send_ev_email(user):
    vcode = generate_code()
    if vcode:
        udetail = user.userdetail
        udetail.erv_code = vcode
        udetail.save()
        html_message = f"<p>Your code for activaiton is: {vcode}</p>"
        mail.send(
            [user.email],
            'noreply@ekurakani.com',
            subject="Verify your account",
            html_message= html_message,
            priority='now',
        )

def send_reset_psw(user):
    reset_code = generate_code()
    if reset_code:
        udetail = user.userdetail
        udetail.reset_code = reset_code
        udetail.save()
        html_message = f"<p>Password reset code is {reset_code}</p>"
        mail.send(
            [user.email],
            'noreply@ekurakani.com',
            subject="Verify your account",
            html_message= html_message,
            priority='now',
        )