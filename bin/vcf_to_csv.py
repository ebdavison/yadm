#! /usr/bin/env python3
import csv
import vobject


def vcf_to_csv(input_vcf, output_csv):
    with open(input_vcf, "r") as vcf_file, open(
        output_csv, "w", newline=""
    ) as csv_file:
        csv_writer = csv.writer(csv_file)
        # Write header
        csv_writer.writerow(
            ["Name", "Address1", "City", "State", "Zip", "Email", "Phone"]
        )

        for vcard in vobject.readComponents(vcf_file):
            name = vcard.fn.value if hasattr(vcard, "fn") else ""
            email = vcard.email.value if hasattr(vcard, "email") else ""
            tel = vcard.tel.value if hasattr(vcard, "tel") else ""
            address = vcard.adr.value if hasattr(vcard, "adr") else ""
            if address:
                street = address.street
                city = address.city
                state = address.region
                zip = address.code
                csv_writer.writerow(
                    [name, street, city, state, zip, email, tel]
                )
            else:
                street = city = state = zip = ""

            # csv_writer.writerow([name, street, city, state, zip, email, tel])


# vcf_to_csv('your_contacts.vcf', 'contacts.csv')
# vcf_to_csv("/mnt/fedora/home/edavison/Downloads/2024-12-05_19-00_xmas list.vcf", "/mnt/fedora/home/edavison/Downloads/2024-12-05_19-00_xmas list.csv")
vcf_to_csv(
    "/opt/Data/Personal/NextCloud/Documents/xmas2024-2.vcf",
    "/opt/Data/Personal/NextCloud/Documents/xmas2024.csv",
)
