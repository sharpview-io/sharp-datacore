# CONTRIBUTION GUIDELINES
Contribution and suggestions are welcome! Although some easy-to-follow rules and best practices are necessary to maintain the high quality of the work.

[sharpview.io](https://www.sharpview.io/) has its own [Slack Group](https://join.slack.com/t/sharpviewio/shared_invite/zt-s5xmmmc6-Cm2Zehs72UKmQqlahfAXCQ) where you can find a space consists primarily, although not solely, of its online presence in mailing lists and activities such as blog postings and comments, the GitHub repository, and so on. Part of the vision of sharpview.io is contributing a pure list of `high quality` datasets for open communities such as academia, both personal and public research, education etc.

The following policy is a guideline to propose new data items and maintain existing items with outdated information:

1. A dataset is considered as `high quality` when one or more of the following criteria are met:
    * Uncommon to obtain in the open community;
    * Difficult to gather with data-mining;
    * Contributing valuable knowledge for a specific domain;
    * Able to be downloaded directly from the linked site, i.e., not barred by login or purchasing;
    * No advertisement! No Spam! No reputation promotion!

2. A new pull request will be merged into the core repository after passing automatic validation and the maintainer's review.

3. An existing dataset item with outdated information (e.g., unavailable site) will be removed after a while without a new update.


## How to contribute a new data entry

1. Fork `sharp-datacore` repository into your own namespace such as `yourname/sharp-datacore`.


2. Clone your project locally:
```bash
git clone https://github.com/yourname/sharp-datacore.git
cd sharp-datacore
```

3. Create a new data entry from template `PULL_REQUEST_TEMPLATE.yml`. 

For example, we want to create `NEW_DATASET.yml` under category folder of `SocialMedia`:
```bash
cp PULL_REQUEST_TEMPLATE.yml ./core/SocialMedia/NEW_DATASET.yml
```
Then edit data fields as you want:
```bash
vim ./core/SocialMedia/NEW_DATASET.yml 
```
For data validation, it requires three essential data fields: `title`, `resource`, `description`, and `category`, while the `category` should be the same as the folder name, i.e., "SocialMedia" in the example.

In a nutshell, you should get a basic entry like
```yaml
---
title: New Dataset Name
resource: https://example.com
description: Short and simple description.
category: SocialMedia
```
Best Practice: End all descriptions with a full stop/period.


4. Run local test to validate your modification:
```bash
# With python
sudo pip install -r tests/requirements.txt
./tests/testing.sh
```

5. Commit local modifications to your repository:
```bash
git add ./core/SocialMedia/NEW_DATASET.yml
git commit -m "Add NEW_DATASET under SocialMedia"  # Any message as you want
git push origin main
```

6. Create a new Pull Request to the trunk repository on Github page, usually `https://github.com/yourname/sharp-datacore/pulls`


Thank you for your contributions and suggestions!
