# Pivovare i njihove lokacije

Ovaj skup podataka izrađen je za prvu laboratorijsku vježbu iz Otvorenog računarstva. Sadrži podatke o 16 pivovara iz 10 država, njihovim lokacijama i pivima. U drugoj vježbi dodano je web-sučelje za pregled, pretragu i preuzimanje podataka.

Podaci o pivovarama i lokacijama preuzeti su iz [Open Brewery DB-a](https://www.openbrewerydb.org/). Podaci o pivima su izmišljeni i služe za potrebe vježbe. U skripti punjenja baze kao izmišljeni su označeni i godina osnutka, godišnja proizvodnja te mogućnost razgledavanja pivovare. Te vrijednosti ne treba koristiti kao stvarne podatke o pivovarama.

## Osnovni podaci

- Naziv skupa: Pivovare i njihove lokacije
- Autor: Marko Zvonar
- Verzija: 1.0
- Namjena: prva laboratorijska vježba iz Otvorenog računarstva
- Izvor: Open Brewery DB, uz dodatne izmišljene podatke
- Licencija: MIT
- Jezik: nazivi atributa su na hrvatskom, a vrijednosti su uglavnom na engleskom i izvornim jezicima
- Baza podataka: PostgreSQL
- Formati izvoza: CSV i JSON
- Kodiranje: UTF-8
- Opseg: 16 pivovara, 20 lokacija i 38 piva
- Prostorni obuhvat: Sjedinjene Američke Države, Njemačka, Irska, Nizozemska, Belgija, Kanada, Austrija, Australija, Novi Zeland i Portugal
- Način izvoza: automatizirani SQL upiti s naredbom `\copy` u alatu `psql`

## Pokretanje web-sučelja

Za pokretanje su potrebni Node.js s npm-om i pokrenut PostgreSQL 18. Naredbe pokreni iz mape projekta.

### Priprema baze

Ako već imaš bazu `pivovare` s podacima iz prve vježbe, prijeđi na pokretanje servera. Za novu bazu pokreni:

```bash
createdb -h 127.0.0.1 -U postgres pivovare
psql -h 127.0.0.1 -U postgres -d pivovare -v ON_ERROR_STOP=1 -f pivovare_dump.sql
```

### Pokretanje servera

```bash
npm ci
npm start
```

`npm ci` instalira pakete iz `package-lock.json`, a `npm start` pokreće server. Ostavi terminal otvoren i u pregledniku otvori [početnu stranicu](http://127.0.0.1:3000/). Server zaustavi s **Ctrl+C**.

Server se prema zadanim postavkama spaja na bazu `pivovare` kao korisnik `postgres` na adresi `127.0.0.1:5432`. Ako koristiš druge postavke, prije pokretanja postavi odgovarajuće varijable `PGDATABASE`, `PGUSER`, `PGHOST` ili `PGPORT`. Ako baza traži lozinku, postavi i `PGPASSWORD` u terminalu.

## Pregled, pretraga i preuzimanje

Na početnoj stranici možeš preuzeti cijeli skup u formatima CSV i JSON te otvoriti [JSON shemu](schema.json) koja opisuje strukturu i tipove podataka u punom JSON izvozu.

Poveznica **Otvori tablicu pivovara** vodi na zasebnu stranicu. Ona preko `/api/pivovare` učitava podatke iz PostgreSQL-a i prikazuje jedan redak po pivovari. Možeš pretražiti pojedini stupac ili svih osam prikazanih stupaca uz opciju **Sva polja**. Gumbi za CSV i JSON preuzimaju retke iz trenutačnog prikaza.

Za probu odaberi **Piva**, upiši `Velvet Hour Amber Ale` i klikni **Pretraži**. U tablici i oba izvoza treba ostati samo **3 Ravens**. Uz **Države** možeš probati `United States`, a uz **Udio alkohola (%)** upiši decimalni broj s točkom, primjerice `5.3`. Za povratak na svih 16 pivovara isprazni unos i ponovno klikni **Pretraži**.

## Organizacija baze

Baza se sastoji od tablica `pivovara`, `tip_pivovare`, `lokacija_pivovare`, `grad`, `regija`, `drzava`, `pivo` i `stil_piva`.

Svaka pivovara ima jedan tip te može imati više lokacija i piva. Lokacija pripada gradu, grad regiji, a regija državi. Svako pivo ima jedan stil. Podaci su odvojeni u povezane tablice kako se isti podaci ne bi nepotrebno ponavljali u bazi.

## CSV i JSON

Datoteke `pivovare.csv` i `pivovare.json` sadrže iste podatke, ali su drukčije organizirane.

U JSON-u svaka pivovara ima svoj objekt s osnovnim atributima i popisima `lokacije` i `piva`. U vanjskom JSON polju nalazi se 16 objekata pivovara.

U CSV-u svi podaci zapisani su u stupcima, a atributi pivovare ponavljaju se uz njezine lokacije i piva. Za pivovaru s više lokacija i više piva izvoze se sve kombinacije njezinih lokacija i piva. Primjerice, tri lokacije i tri piva daju devet redaka. To ne znači da je pojedino pivo vezano uz određenu lokaciju, jer baza ne bilježi tu vezu.

Za podatke iz skripte punjenja CSV ima 49 podatkovnih redaka i 33 stupca. Prvi redak sadrži nazive stupaca. U JSON-u svaki objekt pivovare ima 12 glavnih ključeva: 10 osnovnih atributa te popise lokacija i piva. Ako pivovara nema lokacija ili piva, odgovarajući popis je prazan.

## Opis atributa

### Pivovara

- `id_pivovare`: identifikator pivovare iz Open Brewery DB-a.
- `naziv`: naziv pivovare.
- `id_tipa`: identifikator tipa pivovare u bazi.
- `tip_pivovare`: tip pivovare, primjerice `micro`, `regional` ili `brewpub`.
- `opis_tipa`: kratak opis tipa pivovare.
- `telefon`: kontaktni telefonski broj.
- `web_stranica`: adresa web-stranice pivovare.
- `godina_osnutka`: izmišljena godina osnutka za potrebe vježbe.
- `godisnja_proizvodnja_hl`: izmišljena godišnja proizvodnja u hektolitrima.
- `ima_razgledavanje`: izmišljeni podatak o mogućnosti razgledavanja pivovare.

### Lokacija

U JSON-u ovi se atributi nalaze u objektima unutar popisa `lokacije`, a u CSV-u imaju zasebne stupce.

- `id_lokacije`: identifikator lokacije u bazi.
- `adresa_1`, `adresa_2`, `adresa_3`: dijelovi adrese.
- `postanski_broj`: poštanski broj, spremljen kao tekst radi očuvanja početnih nula i slova.
- `geo_sirina`, `geo_duzina`: geografska širina i dužina u decimalnim stupnjevima.
- `id_grada`, `grad`: identifikator i naziv grada.
- `id_regije`, `regija`: identifikator i naziv regije ili savezne države.
- `id_drzave`, `drzava`: identifikator i naziv države.
- `iso_kod`: dvoslovna oznaka države.

### Pivo

U JSON-u ovi se atributi nalaze u objektima unutar popisa `piva`, a u CSV-u imaju zasebne stupce.

- `id_piva`: identifikator piva u bazi.
- `naziv_piva`: naziv piva.
- `id_stila`: identifikator stila piva u bazi.
- `stil_piva`: naziv stila, primjerice IPA, Lager ili Stout.
- `zemlja_podrijetla`: zemlja podrijetla stila piva, a ne država u kojoj je proizvedeno pojedino pivo.
- `alkohol_postotak`: volumni udio alkohola izražen u postocima.
- `ibu`: gorčina piva izražena u IBU jedinicama.
- `boja_ebc`: boja piva izražena u EBC jedinicama.
- `godina_lansiranja`: godina predstavljanja piva.

Svi podaci o pojedinim pivima su izmišljeni. Nedostajuće vrijednosti u JSON-u zapisane su kao `null`, a u CSV-u kao prazna polja. Logičke vrijednosti u JSON-u zapisane su kao `true` i `false`, a u CSV-u kao `t` i `f`.

## Izvoz podataka

Izvoz podataka napravio sam kroz terminal. Prvo sam otvorio mapu u kojoj se nalazi PostgreSQL 18, a zatim se pomoću alata `psql` spojio na bazu `pivovare` kao korisnik `postgres`. Nakon toga pokrenuo sam dva SQL upita s naredbom `\copy`, jedan za stvaranje datoteke `pivovare.csv`, a drugi za `pivovare.json`. Naredbe sam izvršio izravno u terminalu, bez zasebne skripte za izvoz.

## Licencija i izvor

Skup podataka dijeli se pod licencijom MIT. Ona dopušta korištenje, izmjenu i dijeljenje uz zadržavanje obavijesti o autorskim pravima i teksta licencije. Podaci se daju bez jamstva njihove točnosti ili prikladnosti za određenu namjenu.

Izvorni projekt Open Brewery DB objavljen je pod [licencijom MIT](https://github.com/openbrewerydb/openbrewerydb/blob/master/LICENSE), uz obavijest `Copyright (c) 2025 Open Brewery DB`. Pri dijeljenju preuzetog sadržaja treba zadržati tu obavijest i puni tekst licencije. Puni tekst licencije skupa treba biti priložen u datoteci `LICENSE`.
