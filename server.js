const express = require("express");
const { Pool } = require("pg");

const app = express();

// Zadane postavke za lokalnu bazu. Mogu se promijeniti iz terminala.
const baza = new Pool({
  host: process.env.PGHOST || "127.0.0.1",
  user: process.env.PGUSER || "postgres",
  database: process.env.PGDATABASE || "pivovare",
});

app.get("/api/pivovare", async (req, res) => {
  try {
    const rezultat = await baza.query(`
      SELECT p.naziv, p.godina_osnutka, t.naziv AS tip_pivovare,
        COALESCE(lokacije.gradovi, '') AS gradovi,
        COALESCE(lokacije.drzave, '') AS drzave,
        COALESCE(piva.nazivi, '') AS piva,
        COALESCE(piva.stilovi, '') AS stilovi_piva,
        COALESCE(piva.udio_alkohola, '') AS udio_alkohola
      FROM pivovara p
      JOIN tip_pivovare t ON p.id_tipa = t.id_tipa
      LEFT JOIN (
        SELECT l.id_pivovare,
          STRING_AGG(DISTINCT g.naziv, ', ' ORDER BY g.naziv) AS gradovi,
          STRING_AGG(DISTINCT d.naziv, ', ' ORDER BY d.naziv) AS drzave
        FROM lokacija_pivovare l
        JOIN grad g ON l.id_grada = g.id_grada
        JOIN regija r ON g.id_regije = r.id_regije
        JOIN drzava d ON r.id_drzave = d.id_drzave
        GROUP BY l.id_pivovare
      ) lokacije ON p.id_pivovare = lokacije.id_pivovare
      LEFT JOIN (
        SELECT b.id_pivovare,
          STRING_AGG(b.naziv, ', ' ORDER BY b.naziv) AS nazivi,
          STRING_AGG(DISTINCT s.naziv, ', ' ORDER BY s.naziv) AS stilovi,
          STRING_AGG(DISTINCT b.alkohol_postotak::text, ', '
            ORDER BY b.alkohol_postotak::text) AS udio_alkohola
        FROM pivo b
        JOIN stil_piva s ON b.id_stila = s.id_stila
        GROUP BY b.id_pivovare
      ) piva ON p.id_pivovare = piva.id_pivovare
      ORDER BY p.naziv
    `);
    res.json(rezultat.rows);
  } catch (greska) {
    console.error(greska.message);
    res.status(500).json({ greska: "Ne mogu učitati pivovare." });
  }
});

app.get(["/", "/index.html"], (req, res) => {
  res.sendFile(__dirname + "/index.html");
});

for (const datoteka of ["datatable.html", "pivovare.csv", "pivovare.json", "schema.json", "LICENSE"]) {
  app.get("/" + datoteka, (req, res) => {
    res.sendFile(__dirname + "/" + datoteka);
  });
}

app.listen(3000, "127.0.0.1", () => {
  console.log("Otvori http://127.0.0.1:3000/");
});
