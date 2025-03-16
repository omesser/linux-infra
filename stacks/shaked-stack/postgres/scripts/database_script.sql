SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE SCHEMA IF NOT EXISTS applications_group;

ALTER SCHEMA applications_group OWNER TO shaked;

CREATE SCHEMA if not exists operational_results;

ALTER SCHEMA operational_results OWNER TO shaked;

CREATE SCHEMA if not exists prisma_projects;

ALTER SCHEMA prisma_projects OWNER TO shaked;

SET default_tablespace = '';

SET default_table_access_method = heap;

CREATE TABLE if not exists applications_group.shaked_combined_events (
    site_letter character(50),
    grid_square text,
    pixel smallint,
    start_date_time timestamp without time zone,
    end_date_time timestamp without time zone,
    class character varying(255),
    comment text,
    customer_feedback text,
    file_links text,
    high_priority boolean,
    insert_date_time timestamp without time zone,
    owner character varying(255)
);

ALTER TABLE applications_group.shaked_combined_events OWNER TO shaked;

CREATE TABLE if not exists applications_group.shaked_tasks (
    task_number integer,
    creation_date timestamp without time zone,
    task_type text,
    task_description text,
    created_by character varying(255),
    assigned_to character varying(255),
    due_date date,
    status character varying(255),
    file_links text,
    comments text,
    insert_time timestamp without time zone
);

ALTER TABLE applications_group.shaked_tasks OWNER TO shaked;

CREATE TABLE if not exists operational_results.shaked_e_algoruns (
    algorun_id character varying(64) NOT NULL,
    machine_name character varying(64),
    execution_time_start timestamp without time zone,
    execution_time_end timestamp without time zone,
    algorun_json text,
    collector_key character varying(64),
    collector_time timestamp without time zone,
    collector_json text,
    recording_uuid character varying(64),
    site_id integer,
    recording_start_time timestamp without time zone,
    recording_end_time timestamp without time zone,
    recording_json text,
    fiber_description character varying(64),
    external_params text
);

ALTER TABLE operational_results.shaked_e_algoruns OWNER TO shaked;

CREATE TABLE if not exists operational_results.shaked_e_pulse_alerts (
    id integer NOT NULL,
    site_id integer,
    alert_id integer NOT NULL,
    alert_time timestamp without time zone,
    time_interval_s double precision,
    distance_m double precision,
    start_position_m double precision,
    perpendicular_distance_m double precision,
    width_m double precision,
    class_id bigint,
    score integer,
    is_dead smallint,
    last_trace_loc double precision,
    is_faded smallint,
    is_external smallint,
    algorun_id character varying(36) NOT NULL,
    ind smallint,
    creation_time timestamp without time zone,
    birth_location_m double precision,
    class smallint,
    group_id smallint,
    group_idx smallint,
    age_s double precision,
    displacement_s double precision,
    velocity double precision,
    class_int smallint,
    not_detected_s double precision,
    last_update_time double precision,
    n_updates integer,
    health double precision,
    score_internal double precision,
    n_associated_events smallint,
    class_distrib character varying,
    was_external smallint,
    is_inner_external smallint,
    was_inner_external smallint,
    inner_external_inheritance double precision,
    external_time double precision,
    last_trace_time double precision,
    last_trace_class smallint,
    last_trace_sub_class smallint,
    last_trace_score smallint,
    run text,
    insert_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE operational_results.shaked_e_pulse_alerts OWNER TO shaked;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'operational_results'
        AND table_name = 'shaked_e_pulse_alerts'
        AND column_name = 'id'
        AND is_identity = 'YES'
    ) THEN
        ALTER TABLE operational_results.shaked_e_pulse_alerts ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
            SEQUENCE NAME operational_results.shaked_e_pulse_alerts_id_seq
            START WITH 1
            INCREMENT BY 1
            NO MINVALUE
            NO MAXVALUE
            CACHE 1
        );
    END IF;
END $$;


CREATE TABLE  if not exists operational_results.shaked_g_algoruns (
    algorun_id character varying(64) NOT NULL,
    machine_name character varying(64),
    execution_time_start timestamp without time zone,
    execution_time_end timestamp without time zone,
    algorun_json text,
    collector_key character varying(64),
    collector_time timestamp without time zone,
    collector_json text,
    recording_uuid character varying(64),
    site_id integer,
    recording_start_time timestamp without time zone,
    recording_end_time timestamp without time zone,
    recording_json text,
    fiber_description character varying(64),
    external_params text
);

ALTER TABLE operational_results.shaked_g_algoruns OWNER TO shaked;

CREATE TABLE if not exists operational_results.shaked_g_pulse_alerts (
    id integer NOT NULL,
    site_id integer,
    alert_id integer NOT NULL,
    alert_time timestamp without time zone,
    time_interval_s double precision,
    distance_m double precision,
    start_position_m double precision,
    perpendicular_distance_m double precision,
    width_m double precision,
    class_id bigint,
    score integer,
    is_dead smallint,
    last_trace_loc double precision,
    is_faded smallint,
    is_external smallint,
    algorun_id character varying(36) NOT NULL,
    ind smallint,
    creation_time timestamp without time zone,
    birth_location_m double precision,
    class smallint,
    group_id smallint,
    group_idx smallint,
    age_s double precision,
    displacement_s double precision,
    velocity double precision,
    class_int smallint,
    not_detected_s double precision,
    last_update_time double precision,
    n_updates integer,
    health double precision,
    score_internal double precision,
    n_associated_events smallint,
    class_distrib character varying,
    was_external smallint,
    is_inner_external smallint,
    was_inner_external smallint,
    inner_external_inheritance double precision,
    external_time double precision,
    last_trace_time double precision,
    last_trace_class smallint,
    last_trace_sub_class smallint,
    last_trace_score smallint,
    run text,
    insert_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE operational_results.shaked_g_pulse_alerts OWNER TO shaked;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'operational_results'
        AND table_name = 'shaked_g_pulse_alerts'
        AND column_name = 'id'
        AND is_identity = 'YES'
    ) THEN
        ALTER TABLE operational_results.shaked_g_pulse_alerts ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
            SEQUENCE NAME operational_results.shaked_g_pulse_alerts_id_seq
            START WITH 1
            INCREMENT BY 1
            NO MINVALUE
            NO MAXVALUE
            CACHE 1
        );
    END IF;
END $$;

CREATE TABLE if not exists operational_results.shaked_k_algoruns (
    algorun_id character varying(64) NOT NULL,
    machine_name character varying(64),
    execution_time_start timestamp without time zone,
    execution_time_end timestamp without time zone,
    algorun_json text,
    collector_key character varying(64),
    collector_time timestamp without time zone,
    collector_json text,
    recording_uuid character varying(64),
    site_id integer,
    recording_start_time timestamp without time zone,
    recording_end_time timestamp without time zone,
    recording_json text,
    fiber_description character varying(64),
    external_params text
);

ALTER TABLE operational_results.shaked_k_algoruns OWNER TO shaked;

CREATE TABLE if not exists operational_results.shaked_k_pulse_alerts (
    id integer NOT NULL,
    site_id integer,
    alert_id integer NOT NULL,
    alert_time timestamp without time zone,
    time_interval_s double precision,
    distance_m double precision,
    start_position_m double precision,
    perpendicular_distance_m double precision,
    width_m double precision,
    class_id bigint,
    score integer,
    is_dead smallint,
    last_trace_loc double precision,
    is_faded smallint,
    is_external smallint,
    algorun_id character varying(36) NOT NULL,
    ind smallint,
    creation_time timestamp without time zone,
    birth_location_m double precision,
    class smallint,
    group_id smallint,
    group_idx smallint,
    age_s double precision,
    displacement_s double precision,
    velocity double precision,
    class_int smallint,
    not_detected_s double precision,
    last_update_time double precision,
    n_updates integer,
    health double precision,
    score_internal double precision,
    n_associated_events smallint,
    class_distrib character varying,
    was_external smallint,
    is_inner_external smallint,
    was_inner_external smallint,
    inner_external_inheritance double precision,
    external_time double precision,
    last_trace_time double precision,
    last_trace_class smallint,
    last_trace_sub_class smallint,
    last_trace_score smallint,
    run text,
    insert_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE operational_results.shaked_k_pulse_alerts OWNER TO shaked;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'operational_results'
        AND table_name = 'shaked_k_pulse_alerts'
        AND column_name = 'id'
        AND is_identity = 'YES'
    ) THEN
        ALTER TABLE operational_results.shaked_k_pulse_alerts ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
            SEQUENCE NAME operational_results.shaked_k_pulse_alerts_id_seq
            START WITH 1
            INCREMENT BY 1
            NO MINVALUE
            NO MAXVALUE
            CACHE 1
        );
    END IF;
END $$;

CREATE TABLE if not exists operational_results.shaked_nr_algoruns (
    algorun_id character varying(64) NOT NULL,
    machine_name character varying(64),
    execution_time_start timestamp without time zone,
    execution_time_end timestamp without time zone,
    algorun_json text,
    collector_key character varying(64),
    collector_time timestamp without time zone,
    collector_json text,
    recording_uuid character varying(64),
    site_id integer,
    recording_start_time timestamp without time zone,
    recording_end_time timestamp without time zone,
    recording_json text,
    fiber_description character varying(64),
    external_params text
);

ALTER TABLE operational_results.shaked_nr_algoruns OWNER TO shaked;

CREATE TABLE if not exists operational_results.shaked_nr_pulse_alerts (
    id integer NOT NULL,
    site_id integer,
    alert_id integer NOT NULL,
    alert_time timestamp without time zone,
    time_interval_s double precision,
    distance_m double precision,
    start_position_m double precision,
    perpendicular_distance_m double precision,
    width_m double precision,
    class_id bigint,
    score integer,
    is_dead smallint,
    last_trace_loc double precision,
    is_faded smallint,
    is_external smallint,
    algorun_id character varying(36) NOT NULL,
    ind smallint,
    creation_time timestamp without time zone,
    birth_location_m double precision,
    class smallint,
    group_id smallint,
    group_idx smallint,
    age_s double precision,
    displacement_s double precision,
    velocity double precision,
    class_int smallint,
    not_detected_s double precision,
    last_update_time double precision,
    n_updates integer,
    health double precision,
    score_internal double precision,
    n_associated_events smallint,
    class_distrib character varying,
    was_external smallint,
    is_inner_external smallint,
    was_inner_external smallint,
    inner_external_inheritance double precision,
    external_time double precision,
    last_trace_time double precision,
    last_trace_class smallint,
    last_trace_sub_class smallint,
    last_trace_score smallint,
    run text,
    insert_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE operational_results.shaked_nr_pulse_alerts OWNER TO shaked;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'operational_results'
        AND table_name = 'shaked_nr_pulse_alerts'
        AND column_name = 'id'
        AND is_identity = 'YES'
    ) THEN
        ALTER TABLE operational_results.shaked_nr_pulse_alerts ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
            SEQUENCE NAME operational_results.shaked_nr_pulse_alerts_id_seq
            START WITH 1
            INCREMENT BY 1
            NO MINVALUE
            NO MAXVALUE
            CACHE 1
        );
    END IF;
END $$;


CREATE TABLE if not exists operational_results.shaked_o_algoruns (
    algorun_id character varying(64) NOT NULL,
    machine_name character varying(64),
    execution_time_start timestamp without time zone,
    execution_time_end timestamp without time zone,
    algorun_json text,
    collector_key character varying(64),
    collector_time timestamp without time zone,
    collector_json text,
    recording_uuid character varying(64),
    site_id integer,
    recording_start_time timestamp without time zone,
    recording_end_time timestamp without time zone,
    recording_json text,
    fiber_description character varying(64),
    external_params text
);

ALTER TABLE operational_results.shaked_o_algoruns OWNER TO shaked;

CREATE TABLE if not exists operational_results.shaked_o_pulse_alerts (
    id integer NOT NULL,
    site_id integer,
    alert_id integer NOT NULL,
    alert_time timestamp without time zone,
    time_interval_s double precision,
    distance_m double precision,
    start_position_m double precision,
    perpendicular_distance_m double precision,
    width_m double precision,
    class_id bigint,
    score integer,
    is_dead smallint,
    last_trace_loc double precision,
    is_faded smallint,
    is_external smallint,
    algorun_id character varying(36) NOT NULL,
    ind smallint,
    creation_time timestamp without time zone,
    birth_location_m double precision,
    class smallint,
    group_id smallint,
    group_idx smallint,
    age_s double precision,
    displacement_s double precision,
    velocity double precision,
    class_int smallint,
    not_detected_s double precision,
    last_update_time double precision,
    n_updates integer,
    health double precision,
    score_internal double precision,
    n_associated_events smallint,
    class_distrib character varying,
    was_external smallint,
    is_inner_external smallint,
    was_inner_external smallint,
    inner_external_inheritance double precision,
    external_time double precision,
    last_trace_time double precision,
    last_trace_class smallint,
    last_trace_sub_class smallint,
    last_trace_score smallint,
    run text,
    insert_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE operational_results.shaked_o_pulse_alerts OWNER TO shaked;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'operational_results'
        AND table_name = 'shaked_o_pulse_alerts'
        AND column_name = 'id'
        AND is_identity = 'YES'
    ) THEN
        ALTER TABLE operational_results.shaked_o_pulse_alerts ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
            SEQUENCE NAME operational_results.shaked_o_pulse_alerts_id_seq
            START WITH 1
            INCREMENT BY 1
            NO MINVALUE
            NO MAXVALUE
            CACHE 1
        );
    END IF;
END $$;

CREATE TABLE if not exists prisma_projects.customers (
    id integer,
    name character varying(32),
    region character varying(32),
    bucket character varying(128),
    active smallint DEFAULT 0 NOT NULL
);

ALTER TABLE prisma_projects.customers OWNER TO shaked;

CREATE TABLE if not exists prisma_projects.data_collection_mongo_params (
    id integer NOT NULL,
    site integer NOT NULL,
    site_name character varying(64),
    machine_name character varying(128),
    mongo_db character varying(128),
    collection character varying(128) NOT NULL,
    increment_field character varying(128),
    last_collected_time timestamp without time zone,
    frequency_minutes integer,
    plan_end_time timestamp without time zone,
    enable smallint DEFAULT 1 NOT NULL,
    on_demand smallint DEFAULT 0 NOT NULL
);

ALTER TABLE prisma_projects.data_collection_mongo_params OWNER TO shaked;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'prisma_projects'
        AND table_name = 'data_collection_mongo_params'
        AND column_name = 'id'
        AND is_identity = 'YES'
    ) THEN
        ALTER TABLE operational_results.data_collection_mongo_params ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
            SEQUENCE NAME operational_results.data_collection_mongo_params_id_seq
            START WITH 1
            INCREMENT BY 1
            NO MINVALUE
            NO MAXVALUE
            CACHE 1
        );
    END IF;
END $$;


CREATE TABLE if not exists prisma_projects.sites (
    siteid integer,
    name character varying(64),
    fiberlength_m double precision,
    countrycode character varying,
    timezone character varying(64),
    customer character varying(64),
    application character varying(32),
    machine_name character varying(64),
    ip character varying(32),
    active smallint DEFAULT 0 NOT NULL,
    name_origin character varying(128),
    machine_url   character varying(300)
);

ALTER TABLE prisma_projects.sites OWNER TO shaked;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE table_schema = 'operational_results'
        AND table_name = 'shaked_e_algoruns'
        AND constraint_type = 'PRIMARY KEY'
    ) THEN
        ALTER TABLE ONLY operational_results.shaked_e_algoruns
        ADD CONSTRAINT shaked_e_algoruns_pkey PRIMARY KEY (algorun_id);
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE table_schema = 'operational_results'
        AND table_name = 'shaked_e_pulse_alerts'
        AND constraint_type = 'PRIMARY KEY'
    ) THEN
        ALTER TABLE ONLY operational_results.shaked_e_pulse_alerts
        ADD CONSTRAINT shaked_e_pulse_alerts_pkey PRIMARY KEY (algorun_id);
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE table_schema = 'operational_results'
        AND table_name = 'shaked_g_algoruns'
        AND constraint_type = 'PRIMARY KEY'
    ) THEN
        ALTER TABLE ONLY operational_results.shaked_g_algoruns
        ADD CONSTRAINT shaked_g_algoruns_pkey PRIMARY KEY (algorun_id);
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE table_schema = 'operational_results'
        AND table_name = 'shaked_g_pulse_alerts'
        AND constraint_type = 'PRIMARY KEY'
    ) THEN
        ALTER TABLE ONLY operational_results.shaked_g_pulse_alerts
        ADD CONSTRAINT shaked_g_pulse_alerts_pkey PRIMARY KEY (algorun_id);
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE table_schema = 'operational_results'
        AND table_name = 'shaked_k_algoruns'
        AND constraint_type = 'PRIMARY KEY'
    ) THEN
        ALTER TABLE ONLY operational_results.shaked_k_algoruns
        ADD CONSTRAINT shaked_k_algoruns_pkey PRIMARY KEY (algorun_id);
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE table_schema = 'operational_results'
        AND table_name = 'shaked_k_pulse_alerts'
        AND constraint_type = 'PRIMARY KEY'
    ) THEN
        ALTER TABLE ONLY operational_results.shaked_k_pulse_alerts
        ADD CONSTRAINT shaked_k_pulse_alerts_pkey PRIMARY KEY (algorun_id);
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE table_schema = 'operational_results'
        AND table_name = 'shaked_nr_algoruns'
        AND constraint_type = 'PRIMARY KEY'
    ) THEN
        ALTER TABLE ONLY operational_results.shaked_nr_algoruns
        ADD CONSTRAINT shaked_nr_algoruns_pkey PRIMARY KEY (algorun_id);
    END IF;
END $$;
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE table_schema = 'operational_results'
        AND table_name = 'shaked_nr_pulse_alerts'
        AND constraint_type = 'PRIMARY KEY'
    ) THEN
        ALTER TABLE ONLY operational_results.shaked_nr_pulse_alerts
        ADD CONSTRAINT shaked_nr_pulse_alerts_pkey PRIMARY KEY (algorun_id);
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE table_schema = 'operational_results'
        AND table_name = 'shaked_o_algoruns'
        AND constraint_type = 'PRIMARY KEY'
    ) THEN
        ALTER TABLE ONLY operational_results.shaked_o_algoruns
        ADD CONSTRAINT shaked_o_algoruns_pkey PRIMARY KEY (algorun_id);
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE table_schema = 'operational_results'
        AND table_name = 'shaked_o_pulse_alerts'
        AND constraint_type = 'PRIMARY KEY'
    ) THEN
        ALTER TABLE ONLY operational_results.shaked_o_pulse_alerts
        ADD CONSTRAINT shaked_o_pulse_alerts_pkey PRIMARY KEY (algorun_id);
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE table_schema = 'prisma_projects'
        AND table_name = 'data_collection_mongo_params'
        AND constraint_type = 'PRIMARY KEY'
    ) THEN
        ALTER TABLE ONLY operational_results.data_collection_mongo_params
        ADD CONSTRAINT data_collection_mongo_params_pkey PRIMARY KEY (algorun_id);
    END IF;
END $$;

CREATE INDEX if not exists shaked_e_algorun_id_index ON operational_results.shaked_e_pulse_alerts USING btree (algorun_id);
CREATE INDEX if not exists shaked_e_algoruns_siteid ON operational_results.shaked_e_algoruns USING btree (site_id);
CREATE INDEX if not exists shaked_e_pulse_alerts_alert_id_index ON operational_results.shaked_e_pulse_alerts USING btree (alert_id);
CREATE INDEX if not exists shaked_e_pulse_alerts_alert_time_index ON operational_results.shaked_e_pulse_alerts USING btree (alert_time);
CREATE INDEX if not exists shaked_e_site_fk ON operational_results.shaked_e_pulse_alerts USING btree (site_id);
CREATE INDEX if not exists shaked_g_algorun_id_index ON operational_results.shaked_g_pulse_alerts USING btree (algorun_id);
CREATE INDEX if not exists shaked_g_algoruns_siteid ON operational_results.shaked_g_algoruns USING btree (site_id);
CREATE INDEX if not exists shaked_g_pulse_alerts_alert_id_index ON operational_results.shaked_g_pulse_alerts USING btree (alert_id);
CREATE INDEX if not exists shaked_g_pulse_alerts_alert_time_index ON operational_results.shaked_g_pulse_alerts USING btree (alert_time);
CREATE INDEX if not exists shaked_g_site_fk ON operational_results.shaked_g_pulse_alerts USING btree (site_id);
CREATE INDEX if not exists shaked_k_algorun_id_index ON operational_results.shaked_k_pulse_alerts USING btree (algorun_id);
CREATE INDEX if not exists shaked_k_algoruns_siteid ON operational_results.shaked_k_algoruns USING btree (site_id);
CREATE INDEX if not exists shaked_k_pulse_alerts_alert_id_index ON operational_results.shaked_k_pulse_alerts USING btree (alert_id);
CREATE INDEX if not exists shaked_k_pulse_alerts_alert_time_index ON operational_results.shaked_k_pulse_alerts USING btree (alert_time);
CREATE INDEX if not exists shaked_k_site_fk ON operational_results.shaked_k_pulse_alerts USING btree (site_id);
CREATE INDEX if not exists shaked_nr_algorun_id_index ON operational_results.shaked_nr_pulse_alerts USING btree (algorun_id);
CREATE INDEX if not exists shaked_nr_algoruns_siteid ON operational_results.shaked_nr_algoruns USING btree (site_id);
CREATE INDEX if not exists shaked_nr_pulse_alerts_alert_id_index ON operational_results.shaked_nr_pulse_alerts USING btree (alert_id);
CREATE INDEX if not exists shaked_nr_pulse_alerts_alert_time_index ON operational_results.shaked_nr_pulse_alerts USING btree (alert_time);
CREATE INDEX if not exists shaked_nr_site_fk ON operational_results.shaked_nr_pulse_alerts USING btree (site_id);
CREATE INDEX if not exists shaked_o_algorun_id_index ON operational_results.shaked_o_pulse_alerts USING btree (algorun_id);
CREATE INDEX if not exists shaked_o_algoruns_siteid ON operational_results.shaked_o_algoruns USING btree (site_id);
CREATE INDEX if not exists shaked_o_pulse_alerts_alert_id_index ON operational_results.shaked_o_pulse_alerts USING btree (alert_id);
CREATE INDEX if not exists shaked_o_pulse_alerts_alert_time_index ON operational_results.shaked_o_pulse_alerts USING btree (alert_time);
CREATE INDEX if not exists shaked_o_site_fk ON operational_results.shaked_o_pulse_alerts USING btree (site_id);
CREATE INDEX if not exists mongo_config_site_id_fk ON prisma_projects.data_collection_mongo_params USING btree (site);
CREATE INDEX if not exists siteid ON prisma_projects.sites USING btree (siteid);
CREATE INDEX if not exists sites_name_index ON prisma_projects.sites USING btree (name);
