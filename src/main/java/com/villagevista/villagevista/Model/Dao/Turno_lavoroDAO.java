package com.villagevista.villagevista.Model.Dao;

import com.villagevista.villagevista.Model.Mo.Dipendente;
import com.villagevista.villagevista.Model.Mo.Turno_lavoro;

import java.sql.Date;
import java.util.List;

public interface Turno_lavoroDAO {

    public Turno_lavoro create (
            Long id_dip_turno,
            String ora_inizio,
            String ora_fine,
            String cognome_turno,
            Date data_turno,
            Dipendente dipendente);

        public void update (Turno_lavoro turno_lavoro);

        public void delete (Long turno_id);
        public Turno_lavoro findByCognome_turno(String cognome_turno);
        public Turno_lavoro findByData_turno(Date data_turno);
    public List<Turno_lavoro> findByIdDipTurno(Long id_dip_turno);
        public List<Turno_lavoro> findAllTurni(String cognome_turno);
        public List<Turno_lavoro> findAll();
        public List<Turno_lavoro> findAllWithDipendente();
        public Turno_lavoro findByTurnoId(Long turno_id);
}
