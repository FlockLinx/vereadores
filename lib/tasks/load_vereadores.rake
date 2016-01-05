
require 'csv'
namespace :data do

  desc "load vereadores data"
  headers =  %w(DATA_GERACAO  HORA_GERACAO  ANO_ELEICAO  NUM_TURNO  DESCRICAO_ELEICAO  SIGLA_UF  SIGLA_UE  DESCRICAO_UE  CODIGO_CARGO  DESCRICAO_CARGO  NOME_CANDIDATO  SEQUENCIAL_CANDIDATO  NUMERO_CANDIDATO  CPF_CANDIDATO  NOME_URNA_CANDIDATO  COD_SITUACAO_CANDIDATURA  DES_SITUACAO_CANDIDATURA  NUMERO_PARTIDO  SIGLA_PARTIDO  NOME_PARTIDO  CODIGO_LEGENDA  SIGLA_LEGENDA  COMPOSICAO_LEGENDA  NOME_LEGENDA  CODIGO_OCUPACAO  DESCRICAO_OCUPACAO  DATA_NASCIMENTO  NUM_TITULO_ELEITORAL_CANDIDATO  IDADE_DATA_ELEICAO  CODIGO_SEXO  DESCRICAO_SEXO  COD_GRAU_INSTRUCAO  DESCRICAO_GRAU_INSTRUCAO  CODIGO_ESTADO_CIVIL  DESCRICAO_ESTADO_CIVIL  CODIGO_NACIONALIDADE  DESCRICAO_NACIONALIDADE  SIGLA_UF_NASCIMENTO  CODIGO_MUNICIPIO_NASCIMENTO  NOME_MUNICIPIO_NASCIMENTO  DESPESA_MAX_CAMPANHA  COD_SIT_TOT_TURNO DESC_SIT_TOT_TURNO)

  task :vereadores => :environment do
    election = Election.find_or_create_by(year: "2012")

    CSV.foreach("db/data/consulta_cand_2012_RR.txt", col_sep: ";", encoding: "ISO8859-1") do |row|
      zipped = headers.zip(row)
      hashed = Hash[zipped]
      next if hashed["DESCRICAO_CARGO"] != "VEREADOR"

      campaing_state = State.find_or_create_by(name: hashed["SIGLA_UF"])

      campaing_city = City.find_or_create_by(name:  hashed["DESCRICAO_UE"], state: campaing_state)

      campaing_job = Job.find_or_create_by(name: hashed["DESCRICAO_OCUPACAO"], tse_id: hashed["CODIGO_OCUPACAO"])

      campaing_result = StatusResult.find_or_create_by(name: hashed["DESC_SIT_TOT_TURNO"], tse_id: hashed["COD_SIT_TOT_TURNO"])

      campaing_civil = CivilStatus.find_or_create_by(name: hashed["DESCRICAO_ESTADO_CIVIL"], tse_id: hashed["CODIGO_ESTADO_CIVIL"])

      campaing_education_level = EducationLevel.find_or_create_by(name: hashed["DESCRICAO_GRAU_INSTRUCAO"], tse_id: hashed["COD_GRAU_INSTRUCAO"])

      campaing_application = StatusApplication.find_or_create_by(name: hashed["DES_SITUACAO_CANDIDATURA"], tse_id: hashed["COD_SITUACAO_CANDIDATURA"])

      campaing_party = Party.find_or_create_by(name: hashed["NOME_PARTIDO"], number: hashed["CODIGO_CARGO"], acronym: hashed["SIGLA_PARTIDO"])

      campaing_coaltition = Coalition.find_or_create_by(name: hashed["NOME_LEGENDA"], tse_id: hashed["CODIGO_LEGENDA"], acronym: hashed["SIGLA_LEGENDA"], content: hashed["COMPOSICAO_LEGENDA"])

      CoalitionParty.find_or_create_by(coalition: campaing_coaltition, party: campaing_party)

      politian_state = State.find_or_create_by(name: hashed["SIGLA_UF_NASCIMENTO"])
      politian_city = nil
      politian_city = City.find_or_create_by(name:  hashed["NOME_MUNICIPIO_NASCIMENTO"], state: politian_state)

      campaing_politian = Politian.find_or_create_by(cpf: hashed["CPF_CANDIDATO"], name: hashed["NOME_CANDIDATO"], birth_date: hashed["DATA_NASCIMENTO"], gender: hashed["CODIGO_SEXO"], nationality: hashed["CODIGO_NACIONALIDADE"], birth_city: politian_city, voter_number: hashed["NUM_TITULO_ELEITORAL_CANDIDATO"])

      campaing = Campaing.find_or_create_by(generate_date: hashed["DATA_GERACAO"], tse_id: hashed["SEQUENCIAL_CANDIDATO"], budget: hashed["DESPESA_MAX_CAMPANHA"], civil_status: campaing_civil, number: hashed["NUMERO_CANDIDATO"], name_campain: hashed["NOME_URNA_CANDIDATO"],
      coalition: campaing_coaltition, party: campaing_party, job: campaing_job, politian: campaing_politian, city: campaing_city, education_level: campaing_education_level, status_application: campaing_application, election: election, status_result: campaing_result)

    end
  end
end
