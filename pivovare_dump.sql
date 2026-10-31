--
-- PostgreSQL database dump
--

\restrict iokCaYws04UT7dCDyTcVxVP6JmOfae442XtwyBZZ45NCw8tIqcizLx6GpsEB8y8

-- Dumped from database version 18.0 (Homebrew)
-- Dumped by pg_dump version 18.0 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: drzava; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.drzava (
    id_drzave integer NOT NULL,
    naziv character varying(100) NOT NULL,
    iso_kod character(2)
);


--
-- Name: drzava_id_drzave_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.drzava_id_drzave_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: drzava_id_drzave_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.drzava_id_drzave_seq OWNED BY public.drzava.id_drzave;


--
-- Name: grad; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.grad (
    id_grada integer NOT NULL,
    naziv character varying(150) NOT NULL,
    id_regije integer NOT NULL
);


--
-- Name: grad_id_grada_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.grad_id_grada_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: grad_id_grada_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.grad_id_grada_seq OWNED BY public.grad.id_grada;


--
-- Name: lokacija_pivovare; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lokacija_pivovare (
    id_lokacije integer NOT NULL,
    id_pivovare character varying(100) NOT NULL,
    adresa_1 character varying(255),
    adresa_2 character varying(255),
    adresa_3 character varying(255),
    postanski_broj character varying(20),
    id_grada integer NOT NULL,
    geo_sirina numeric(9,6),
    geo_duzina numeric(9,6),
    CONSTRAINT lokacija_pivovare_geo_duzina_check CHECK (((geo_duzina >= ('-180'::integer)::numeric) AND (geo_duzina <= (180)::numeric))),
    CONSTRAINT lokacija_pivovare_geo_sirina_check CHECK (((geo_sirina >= ('-90'::integer)::numeric) AND (geo_sirina <= (90)::numeric)))
);


--
-- Name: lokacija_pivovare_id_lokacije_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lokacija_pivovare_id_lokacije_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lokacija_pivovare_id_lokacije_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lokacija_pivovare_id_lokacije_seq OWNED BY public.lokacija_pivovare.id_lokacije;


--
-- Name: pivo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pivo (
    id_piva integer NOT NULL,
    id_pivovare character varying(100) NOT NULL,
    id_stila integer NOT NULL,
    naziv character varying(150) NOT NULL,
    alkohol_postotak numeric(3,1),
    ibu smallint,
    boja_ebc smallint,
    godina_lansiranja smallint,
    CONSTRAINT pivo_alkohol_postotak_check CHECK (((alkohol_postotak >= (0)::numeric) AND (alkohol_postotak <= (20)::numeric))),
    CONSTRAINT pivo_boja_ebc_check CHECK (((boja_ebc >= 0) AND (boja_ebc <= 140))),
    CONSTRAINT pivo_godina_lansiranja_check CHECK (((godina_lansiranja >= 1000) AND (godina_lansiranja <= 2100))),
    CONSTRAINT pivo_ibu_check CHECK (((ibu >= 0) AND (ibu <= 120)))
);


--
-- Name: pivo_id_piva_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pivo_id_piva_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pivo_id_piva_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pivo_id_piva_seq OWNED BY public.pivo.id_piva;


--
-- Name: pivovara; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pivovara (
    id_pivovare character varying(100) NOT NULL,
    naziv character varying(255) NOT NULL,
    id_tipa integer NOT NULL,
    telefon character varying(30),
    web_stranica character varying(500),
    godina_osnutka smallint,
    godisnja_proizvodnja_hl integer,
    ima_razgledavanje boolean DEFAULT false,
    CONSTRAINT pivovara_godina_osnutka_check CHECK (((godina_osnutka >= 1000) AND (godina_osnutka <= 2100))),
    CONSTRAINT pivovara_godisnja_proizvodnja_hl_check CHECK ((godisnja_proizvodnja_hl >= 0))
);


--
-- Name: regija; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.regija (
    id_regije integer NOT NULL,
    naziv character varying(100) NOT NULL,
    id_drzave integer NOT NULL
);


--
-- Name: regija_id_regije_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.regija_id_regije_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: regija_id_regije_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.regija_id_regije_seq OWNED BY public.regija.id_regije;


--
-- Name: stil_piva; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stil_piva (
    id_stila integer NOT NULL,
    naziv character varying(100) NOT NULL,
    zemlja_podrijetla character varying(100)
);


--
-- Name: stil_piva_id_stila_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stil_piva_id_stila_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stil_piva_id_stila_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stil_piva_id_stila_seq OWNED BY public.stil_piva.id_stila;


--
-- Name: tip_pivovare; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tip_pivovare (
    id_tipa integer NOT NULL,
    naziv character varying(30) NOT NULL,
    opis text
);


--
-- Name: tip_pivovare_id_tipa_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tip_pivovare_id_tipa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tip_pivovare_id_tipa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tip_pivovare_id_tipa_seq OWNED BY public.tip_pivovare.id_tipa;


--
-- Name: drzava id_drzave; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.drzava ALTER COLUMN id_drzave SET DEFAULT nextval('public.drzava_id_drzave_seq'::regclass);


--
-- Name: grad id_grada; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grad ALTER COLUMN id_grada SET DEFAULT nextval('public.grad_id_grada_seq'::regclass);


--
-- Name: lokacija_pivovare id_lokacije; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lokacija_pivovare ALTER COLUMN id_lokacije SET DEFAULT nextval('public.lokacija_pivovare_id_lokacije_seq'::regclass);


--
-- Name: pivo id_piva; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pivo ALTER COLUMN id_piva SET DEFAULT nextval('public.pivo_id_piva_seq'::regclass);


--
-- Name: regija id_regije; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regija ALTER COLUMN id_regije SET DEFAULT nextval('public.regija_id_regije_seq'::regclass);


--
-- Name: stil_piva id_stila; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stil_piva ALTER COLUMN id_stila SET DEFAULT nextval('public.stil_piva_id_stila_seq'::regclass);


--
-- Name: tip_pivovare id_tipa; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tip_pivovare ALTER COLUMN id_tipa SET DEFAULT nextval('public.tip_pivovare_id_tipa_seq'::regclass);


--
-- Data for Name: drzava; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.drzava (id_drzave, naziv, iso_kod) FROM stdin;
1	United States	US
2	Germany	DE
3	Ireland	IE
4	Netherlands	NL
5	Belgium	BE
6	Canada	CA
7	Austria	AT
8	Australia	AU
9	New Zealand	NZ
10	Portugal	PT
\.


--
-- Data for Name: grad; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.grad (id_grada, naziv, id_regije) FROM stdin;
1	Mill Creek	1
2	Grand Rapids	2
3	Chico	5
4	Rehoboth Beach	3
5	Milton	3
6	San Diego	5
7	Richmond	4
8	Escondido	5
9	München	6
10	Dublin	7
11	Amsterdam	8
12	Brugge	9
13	Courtenay	10
14	Leoben	11
15	Thornbury	12
16	Hamilton	13
17	Warkworth	14
18	Lisboa	15
\.


--
-- Data for Name: lokacija_pivovare; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lokacija_pivovare (id_lokacije, id_pivovare, adresa_1, adresa_2, adresa_3, postanski_broj, id_grada, geo_sirina, geo_duzina) FROM stdin;
1	7c669ae6-460d-476b-bc56-0b4d566a152c	16709 9th Ave SE	\N	\N	98012-6309	1	47.846714	-122.219914
2	e4da6e5d-1e64-4701-ab21-786b0f3a1ff4	235 Grandville Ave SW	\N	\N	49503-4037	2	42.952496	-85.676575
3	70e66be3-fd92-4db0-86f3-0f05807cc4e2	1075 E 20th St	\N	\N	95928-6722	3	39.725763	-121.809880
4	281e6980-e2e2-4493-9896-3517e8cafe21	320 Rehoboth Ave	\N	\N	19971-3108	4	38.715177	-75.087315
5	281e6980-e2e2-4493-9896-3517e8cafe21	6 Cannery Village Ctr	\N	\N	19968-1308	5	38.766912	-75.311582
6	d955991a-9377-4f2c-baf3-b561a72bf895	2816 Historic Decatur Rd Ste 116	\N	\N	92106-6164	6	32.740524	-117.211570
7	d955991a-9377-4f2c-baf3-b561a72bf895	4300 Williamsburg Ave	\N	\N	23231-1225	7	37.524110	-77.414763
8	d955991a-9377-4f2c-baf3-b561a72bf895	2120 Harmony Grove Rd	\N	\N	92029-2053	8	33.109969	-117.115650
9	59b8d88c-8628-46d1-bf5e-999cd8e158b4	Hochstraße 77	\N	\N	81541	9	48.121522	11.583204
10	59b8d88c-8628-46d1-bf5e-999cd8e158b4	Kapuzinerplatz 5	\N	\N	80337	9	48.126305	11.558832
11	b82b05d8-ca46-4954-b9a9-bb91a98406e5	St. James's Gate	Dublin 8	\N	D08 VF8H	10	53.341933	-6.286730
12	84824834-3233-4947-ad20-579b7141fc24	Funenkade 7	\N	\N	1018 AL	11	52.366691	4.926425
13	c4b543bd-313d-4cf7-b9c6-b8f58e326d58	Stadhouderskade 78	\N	\N	1072 AE	11	52.357831	4.891825
14	943def61-1dce-45c2-9e40-6454bbad65fc	26 Walplein	\N	\N	8000	12	51.202447	3.224178
15	ed1a10cd-0170-48d1-ae91-8c54e37e98b5	244 4th Street	\N	\N	V9N 1G6	13	49.691771	-124.998183
16	fcd9312c-7531-4801-b481-52f4267cf628	Brauhausgasse 1	\N	\N	8700	14	47.362557	15.093344
17	50f26a2b-242d-40af-b78b-cf975ce37761	260 Dundas Street	\N	\N	3071	15	-37.755894	145.026872
18	c02412dc-7507-4047-9497-9066e454c4e1	34 Mahana Road	\N	\N	3200	16	-37.758944	175.251568
19	2a7c0677-5ac3-4ed9-917e-b6214c389ded	26 Glenmore Drive	\N	\N	0910	17	-36.409042	174.654817
20	27d18114-31bb-4baf-b330-71bcba80cc8a	Rua Capitão Leitão, 94	\N	\N	1950-052	18	38.738267	-9.105483
\.


--
-- Data for Name: pivo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pivo (id_piva, id_pivovare, id_stila, naziv, alkohol_postotak, ibu, boja_ebc, godina_lansiranja) FROM stdin;
1	c02412dc-7507-4047-9497-9066e454c4e1	1	Blue Anchor Lager	4.7	23	7	2015
2	fcd9312c-7531-4801-b481-52f4267cf628	1	Cobble Street Lager	4.6	20	12	2020
3	59b8d88c-8628-46d1-bf5e-999cd8e158b4	1	Stone Orchard Lager	4.4	24	11	2016
4	27d18114-31bb-4baf-b330-71bcba80cc8a	2	Juniper Row Pilsner	5.0	44	6	2020
5	fcd9312c-7531-4801-b481-52f4267cf628	2	Iron Bridge Pilsner	4.5	31	7	1978
6	84824834-3233-4947-ad20-579b7141fc24	2	Lazy River Pilsner	5.2	42	7	1990
7	b82b05d8-ca46-4954-b9a9-bb91a98406e5	2	Whistling Kite Pilsner	5.3	33	10	1997
8	ed1a10cd-0170-48d1-ae91-8c54e37e98b5	3	Old Mill IPA	7.1	46	15	2005
9	c4b543bd-313d-4cf7-b9c6-b8f58e326d58	3	Mossy Stone IPA	6.5	43	23	1954
10	70e66be3-fd92-4db0-86f3-0f05807cc4e2	3	Salt Cove IPA	6.7	52	24	2015
11	281e6980-e2e2-4493-9896-3517e8cafe21	3	Silent Orchard IPA	6.0	57	29	1997
12	d955991a-9377-4f2c-baf3-b561a72bf895	3	Copper Hour IPA	6.8	57	19	1992
13	7c669ae6-460d-476b-bc56-0b4d566a152c	4	Golden Field Pale Ale	4.9	39	17	2020
14	c02412dc-7507-4047-9497-9066e454c4e1	4	Harbor Pale Ale	5.5	31	10	2024
15	e4da6e5d-1e64-4701-ab21-786b0f3a1ff4	4	Sunday Fields Pale Ale	5.7	40	11	2014
16	59b8d88c-8628-46d1-bf5e-999cd8e158b4	4	Paper Moon Pale Ale	5.6	42	14	2008
17	7c669ae6-460d-476b-bc56-0b4d566a152c	5	Cold Spring Stout	7.8	59	74	2015
18	2a7c0677-5ac3-4ed9-917e-b6214c389ded	5	Driftwood Stout	6.9	53	120	2024
19	943def61-1dce-45c2-9e40-6454bbad65fc	5	Lantern Hill Stout	8.0	50	93	2021
20	b82b05d8-ca46-4954-b9a9-bb91a98406e5	5	Foggy Ridge Stout	5.1	59	76	2024
21	281e6980-e2e2-4493-9896-3517e8cafe21	5	Old Lantern Stout	7.1	43	107	2006
22	c4b543bd-313d-4cf7-b9c6-b8f58e326d58	6	Distant Shore Porter	5.6	36	50	1958
23	b82b05d8-ca46-4954-b9a9-bb91a98406e5	6	Wandering Crow Porter	5.4	34	50	1986
24	d955991a-9377-4f2c-baf3-b561a72bf895	6	Northern Lights Porter	5.2	28	54	2020
25	7c669ae6-460d-476b-bc56-0b4d566a152c	7	Crooked Fence Weissbier	5.2	14	9	2016
26	27d18114-31bb-4baf-b330-71bcba80cc8a	7	Saffron Sky Weissbier	5.6	14	11	2023
27	2a7c0677-5ac3-4ed9-917e-b6214c389ded	7	Lucky Heron Weissbier	5.5	13	12	2020
28	943def61-1dce-45c2-9e40-6454bbad65fc	7	Amber Dusk Weissbier	5.5	13	9	2017
29	70e66be3-fd92-4db0-86f3-0f05807cc4e2	7	Tin Roof Weissbier	5.6	14	12	2012
30	50f26a2b-242d-40af-b78b-cf975ce37761	8	Velvet Hour Amber Ale	4.6	25	27	2016
31	84824834-3233-4947-ad20-579b7141fc24	8	Lone Pine Amber Ale	5.5	30	33	2015
32	c02412dc-7507-4047-9497-9066e454c4e1	9	Thistle Down Saison	6.9	22	10	2016
33	50f26a2b-242d-40af-b78b-cf975ce37761	9	Quiet Harbor Saison	5.3	35	15	2015
34	ed1a10cd-0170-48d1-ae91-8c54e37e98b5	9	Little Falcon Saison	6.4	35	11	2017
35	fcd9312c-7531-4801-b481-52f4267cf628	10	Slow River Gose	4.4	11	8	1945
36	e4da6e5d-1e64-4701-ab21-786b0f3a1ff4	10	Copper Kettle Gose	4.0	5	9	1986
37	281e6980-e2e2-4493-9896-3517e8cafe21	10	Open Road Gose	4.4	7	14	2012
38	d955991a-9377-4f2c-baf3-b561a72bf895	10	Bramble Path Gose	4.5	9	14	1996
\.


--
-- Data for Name: pivovara; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pivovara (id_pivovare, naziv, id_tipa, telefon, web_stranica, godina_osnutka, godisnja_proizvodnja_hl, ima_razgledavanje) FROM stdin;
27d18114-31bb-4baf-b330-71bcba80cc8a	Dois Corvos Cervejeira, Lda.	1	+351 211 331 093	https://www.doiscorvos.pt	2014	1400	f
2a7c0677-5ac3-4ed9-917e-b6214c389ded	8 Wired	1	+64 9 945 3983	http://8wired.co.nz/	2007	1300	t
50f26a2b-242d-40af-b78b-cf975ce37761	3 Ravens	1	+61 424 707 592	https://3ravens.com.au/index	2009	4400	f
ed1a10cd-0170-48d1-ae91-8c54e37e98b5	Gladstone Brewing Company	1	12508711111	http://www.gladstonebrewing.ca/	2002	4900	f
943def61-1dce-45c2-9e40-6454bbad65fc	Huisbrouwerij De Halve Maan	1	+32 50 44 42 25	http://www.halvemaan.be/	2014	7200	f
e4da6e5d-1e64-4701-ab21-786b0f3a1ff4	Founders Brewing Co	3	6167761195	http://www.foundersbrewing.com	1982	53600	t
84824834-3233-4947-ad20-579b7141fc24	Brouwerij 't IJ	3	+31 020 261 9801	https://www.brouwerijhetij.nl/proeflokalen/proeflokaal-de-molen	1982	50400	t
70e66be3-fd92-4db0-86f3-0f05807cc4e2	Sierra Nevada Brewing Co	3	5308933520	http://www.sierranevada.com	1977	44700	f
281e6980-e2e2-4493-9896-3517e8cafe21	Dogfish Head Craft Brewery	3	3026841000	http://www.dogfish.com	1981	363600	t
d955991a-9377-4f2c-baf3-b561a72bf895	Stone Brewing Co	3	7602947866	http://www.stonebrewing.com	1982	73000	t
59b8d88c-8628-46d1-bf5e-999cd8e158b4	Paulaner	4	+49 89 5446117	http://www.paulaner.de	2006	3200	f
fcd9312c-7531-4801-b481-52f4267cf628	Gösser Brauerei (Heineken)	5	+438102069791	https://www.goesser.at	1910	3472100	t
c4b543bd-313d-4cf7-b9c6-b8f58e326d58	Heineken	5	+31 020 205 0593	https://www.heinekenexperience.com/	1876	4758600	t
b82b05d8-ca46-4954-b9a9-bb91a98406e5	Guinness Brewing (Diageo)	5	35314084800	https://www.guinness-storehouse.com/en	1802	1460900	t
c02412dc-7507-4047-9497-9066e454c4e1	666 Brewing	10	+64 7 282 0254	http://www.brewaucracy.co.nz/	2015	2193	t
7c669ae6-460d-476b-bc56-0b4d566a152c	4 Stitch Brewing Co - Brewery & Taproom	11	4252247583	https://www.4stitchbrewing.com	2015	2600	t
\.


--
-- Data for Name: regija; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.regija (id_regije, naziv, id_drzave) FROM stdin;
1	Washington	1
2	Michigan	1
3	Delaware	1
4	Virginia	1
5	California	1
6	Bayern	2
7	Dublin	3
8	Noord-Holland	4
9	Vlaanderen	5
10	British Columbia	6
11	Steiermark	7
12	VIC	8
13	Waikato Region	9
14	Auckland	9
15	Lisboa	10
\.


--
-- Data for Name: stil_piva; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.stil_piva (id_stila, naziv, zemlja_podrijetla) FROM stdin;
1	Lager	Njemačka
2	Pilsner	Češka
3	IPA	Ujedinjeno Kraljevstvo
4	Pale Ale	Ujedinjeno Kraljevstvo
5	Stout	Irska
6	Porter	Ujedinjeno Kraljevstvo
7	Weissbier	Njemačka
8	Amber Ale	Sjedinjene Američke Države
9	Saison	Belgija
10	Gose	Njemačka
\.


--
-- Data for Name: tip_pivovare; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tip_pivovare (id_tipa, naziv, opis) FROM stdin;
1	micro	Mala nezavisna pivovara
2	nano	Vrlo mala pivovara, često kućna
3	regional	Regionalna pivovara
4	brewpub	Pivovara s pivnicom ili restoranom
5	large	Velika industrijska pivovara
6	planning	Pivovara u planiranju, još nije otvorena
7	bar	Bar s vlastitim pivom
8	contract	Ugovorna pivovara, vari za drugi brend
9	proprietor	Pivovara s izmjeničnim vlasnikom (alternating proprietor)
10	closed	Zatvorena pivovara
11	taproom	Pivnica/točionica uz pivovaru
12	cidery	Proizvođač jabukovače
13	beergarden	Pivski vrt
\.


--
-- Name: drzava_id_drzave_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.drzava_id_drzave_seq', 10, true);


--
-- Name: grad_id_grada_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.grad_id_grada_seq', 18, true);


--
-- Name: lokacija_pivovare_id_lokacije_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lokacija_pivovare_id_lokacije_seq', 20, true);


--
-- Name: pivo_id_piva_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pivo_id_piva_seq', 38, true);


--
-- Name: regija_id_regije_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.regija_id_regije_seq', 15, true);


--
-- Name: stil_piva_id_stila_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.stil_piva_id_stila_seq', 10, true);


--
-- Name: tip_pivovare_id_tipa_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tip_pivovare_id_tipa_seq', 13, true);


--
-- Name: drzava drzava_naziv_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.drzava
    ADD CONSTRAINT drzava_naziv_key UNIQUE (naziv);


--
-- Name: drzava drzava_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.drzava
    ADD CONSTRAINT drzava_pkey PRIMARY KEY (id_drzave);


--
-- Name: grad grad_naziv_id_regije_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grad
    ADD CONSTRAINT grad_naziv_id_regije_key UNIQUE (naziv, id_regije);


--
-- Name: grad grad_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grad
    ADD CONSTRAINT grad_pkey PRIMARY KEY (id_grada);


--
-- Name: lokacija_pivovare lokacija_pivovare_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lokacija_pivovare
    ADD CONSTRAINT lokacija_pivovare_pkey PRIMARY KEY (id_lokacije);


--
-- Name: pivo pivo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pivo
    ADD CONSTRAINT pivo_pkey PRIMARY KEY (id_piva);


--
-- Name: pivovara pivovara_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pivovara
    ADD CONSTRAINT pivovara_pkey PRIMARY KEY (id_pivovare);


--
-- Name: regija regija_naziv_id_drzave_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regija
    ADD CONSTRAINT regija_naziv_id_drzave_key UNIQUE (naziv, id_drzave);


--
-- Name: regija regija_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regija
    ADD CONSTRAINT regija_pkey PRIMARY KEY (id_regije);


--
-- Name: stil_piva stil_piva_naziv_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stil_piva
    ADD CONSTRAINT stil_piva_naziv_key UNIQUE (naziv);


--
-- Name: stil_piva stil_piva_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stil_piva
    ADD CONSTRAINT stil_piva_pkey PRIMARY KEY (id_stila);


--
-- Name: tip_pivovare tip_pivovare_naziv_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tip_pivovare
    ADD CONSTRAINT tip_pivovare_naziv_key UNIQUE (naziv);


--
-- Name: tip_pivovare tip_pivovare_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tip_pivovare
    ADD CONSTRAINT tip_pivovare_pkey PRIMARY KEY (id_tipa);


--
-- Name: idx_grad_regija; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_grad_regija ON public.grad USING btree (id_regije);


--
-- Name: idx_lokacija_grad; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_lokacija_grad ON public.lokacija_pivovare USING btree (id_grada);


--
-- Name: idx_lokacija_pivovara; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_lokacija_pivovara ON public.lokacija_pivovare USING btree (id_pivovare);


--
-- Name: idx_pivo_pivovara; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pivo_pivovara ON public.pivo USING btree (id_pivovare);


--
-- Name: idx_pivo_stil; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pivo_stil ON public.pivo USING btree (id_stila);


--
-- Name: idx_pivovara_tip; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pivovara_tip ON public.pivovara USING btree (id_tipa);


--
-- Name: idx_regija_drzava; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_regija_drzava ON public.regija USING btree (id_drzave);


--
-- Name: grad grad_id_regije_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grad
    ADD CONSTRAINT grad_id_regije_fkey FOREIGN KEY (id_regije) REFERENCES public.regija(id_regije);


--
-- Name: lokacija_pivovare lokacija_pivovare_id_grada_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lokacija_pivovare
    ADD CONSTRAINT lokacija_pivovare_id_grada_fkey FOREIGN KEY (id_grada) REFERENCES public.grad(id_grada);


--
-- Name: lokacija_pivovare lokacija_pivovare_id_pivovare_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lokacija_pivovare
    ADD CONSTRAINT lokacija_pivovare_id_pivovare_fkey FOREIGN KEY (id_pivovare) REFERENCES public.pivovara(id_pivovare) ON DELETE CASCADE;


--
-- Name: pivo pivo_id_pivovare_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pivo
    ADD CONSTRAINT pivo_id_pivovare_fkey FOREIGN KEY (id_pivovare) REFERENCES public.pivovara(id_pivovare) ON DELETE CASCADE;


--
-- Name: pivo pivo_id_stila_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pivo
    ADD CONSTRAINT pivo_id_stila_fkey FOREIGN KEY (id_stila) REFERENCES public.stil_piva(id_stila);


--
-- Name: pivovara pivovara_id_tipa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pivovara
    ADD CONSTRAINT pivovara_id_tipa_fkey FOREIGN KEY (id_tipa) REFERENCES public.tip_pivovare(id_tipa);


--
-- Name: regija regija_id_drzave_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regija
    ADD CONSTRAINT regija_id_drzave_fkey FOREIGN KEY (id_drzave) REFERENCES public.drzava(id_drzave);


--
-- PostgreSQL database dump complete
--

\unrestrict iokCaYws04UT7dCDyTcVxVP6JmOfae442XtwyBZZ45NCw8tIqcizLx6GpsEB8y8

