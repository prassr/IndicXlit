# IndicXlit

The file `word_xlit_json.sh` is created to run the transliteration over json lines file. It captures the two keys ` text ` (text to transliterate) and ` filepath ` (for example. "hello.wav")

#### How to run ` word_xlit_json.sh `

* Install command line json parser `jq`

```bash
apt-get install jq
```

* Running ` word_xlit_json.sh `

  - input file: ` metadata.json `
  - language_id: ` mr `
  - output file: ` mr_en_xlit.tsv `

```bash
bash word_xlit_json.sh metadata.json "mr" mr_en_xlit.tsv
```


* Output format in `mr_en_xlit.tsv`

```
f_1.wav	['sahaa', 'ziro', 'aththavis', 'yaa', 'pinkodchya', 'jawalpas', 'konee', 'suvidha', 'aahe', 'jee', 'athara', 'varsh', 'vaygatatil', 'lokanna', 'pahila', 'doses', 'puravat']
f_2.wav	['majhya', 'mammini', 'majhyasathi', 'khoop', 'kahee', 'kelele', 'aahe', 'tine', 'kasht', 'v', 'sagalam', 'hay', 'majhyasathich', 'kelelam']
```

  - file path and list of words is tab separated.


#### colab file for reference

[colab](https://colab.research.google.com/drive/1HeBhjcVC10j0d9-JaVHI2DzrzxmHUX-d?usp=sharing)