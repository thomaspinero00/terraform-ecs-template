
# 🌐 How to Get Route53 NameServers and Update Your DNS Provider

This guide will help you retrieve your AWS Route53 NameServers and configure them in your domain registrar (e.g., GoDaddy, Namecheap, etc.).

---

## ✅ Step 1: Get your Hosted Zone ID

Run the following command, replacing `<YOUR_DOMAIN>` with your actual domain:

```bash
aws route53 list-hosted-zones-by-name --dns-name <YOUR_DOMAIN>
```

### ✅ Example:

```bash
aws route53 list-hosted-zones-by-name --dns-name tradenethub.com
```

#### ✅ Sample Output:

```json
{
  "HostedZones": [
    {
      "Id": "/hostedzone/Z0599644366LHF6SUYMLK",
      "Name": "example.com.",
      "CallerReference": "terraform-20250619211343029900000001",
      "Config": {
        "Comment": "Managed by Terraform",
        "PrivateZone": false
      },
      "ResourceRecordSetCount": 3
    }
  ],
  "DNSName": "example.com",
  "IsTruncated": false,
  "MaxItems": "100"
}
```

---

## ✅ Step 2: Get your NameServers

Use the `HostedZoneId` you obtained above (omit the `/hostedzone/` prefix if necessary):

```bash
aws route53 get-hosted-zone --id /hostedzone/<HOSTED_ZONE_ID> \
  --query "DelegationSet.NameServers" \
  --output text
```

### ✅ Example:

```bash
aws route53 get-hosted-zone --id /hostedzone/Z06442391HNEV2UXB75GT \
  --query "DelegationSet.NameServers" \
  --output text
```

#### ✅ Sample Output:

```
ns-89.awsdns-11.com     ns-1069.awsdns-05.org   ns-971.awsdns-57.net    ns-1574.awsdns-04.co.uk
```

---

## ✅ Step 3: Update the DNS Provider (e.g., GoDaddy)

1. Log in to your DNS provider (e.g., GoDaddy).
2. Go to **My Domains** → Select your domain → Click **DNS** or **Manage DNS**.
3. Replace the existing **Nameservers** with the ones returned by AWS.
4. Save changes.

Example:

![Nameservers edition example.](/nameservers_edition_example.jpeg "Nameservers edition example.")

🕐 Note: DNS propagation may take up to 24–48 hours, but it's usually faster.

## 🧑‍💻 Author
Built by **@thomaspinero00**