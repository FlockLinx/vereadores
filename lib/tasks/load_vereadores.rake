
require 'csv'
namespace :data do

  class String

    def titleize_latin
      self.mb_chars.downcase.titleize.to_s.gsub(/ D(a|e|o|as|os) /, ' d\1 ').gsub(/ E /, ' e ')
    end
  end
  desc "load vereadores data"
  task :vereadores => :environment do
    election = Election.find_or_create_by(year: "2012")
    csv_files = Dir["db/data/*.txt"]
    csv_files.each do |f|
      load_vereador(f, election)
    end
  end

  desc "load states names"
  task :states => :environment do
    CSV.foreach("db/data/states.csv", col_sep: ";", headers: true) do |row|
      hash = row.to_hash
      state = State.find_by(name: hash["abbreviation"])
      state.update(full_name: hash["name"])
      puts state.inspect
    end
  end

  def load_vereador(f, election)
    headers =  %w(DATA_GERACAO  HORA_GERACAO  ANO_ELEICAO  NUM_TURNO  DESCRICAO_ELEICAO  SIGLA_UF  SIGLA_UE  DESCRICAO_UE  CODIGO_CARGO  DESCRICAO_CARGO  NOME_CANDIDATO  SEQUENCIAL_CANDIDATO  NUMERO_CANDIDATO  CPF_CANDIDATO  NOME_URNA_CANDIDATO  COD_SITUACAO_CANDIDATURA  DES_SITUACAO_CANDIDATURA  NUMERO_PARTIDO  SIGLA_PARTIDO  NOME_PARTIDO  CODIGO_LEGENDA  SIGLA_LEGENDA  COMPOSICAO_LEGENDA  NOME_LEGENDA  CODIGO_OCUPACAO  DESCRICAO_OCUPACAO  DATA_NASCIMENTO  NUM_TITULO_ELEITORAL_CANDIDATO  IDADE_DATA_ELEICAO  CODIGO_SEXO  DESCRICAO_SEXO  COD_GRAU_INSTRUCAO  DESCRICAO_GRAU_INSTRUCAO  CODIGO_ESTADO_CIVIL  DESCRICAO_ESTADO_CIVIL  CODIGO_NACIONALIDADE  DESCRICAO_NACIONALIDADE  SIGLA_UF_NASCIMENTO  CODIGO_MUNICIPIO_NASCIMENTO  NOME_MUNICIPIO_NASCIMENTO  DESPESA_MAX_CAMPANHA  COD_SIT_TOT_TURNO DESC_SIT_TOT_TURNO)
    CSV.foreach(f, col_sep: ";", encoding: "ISO8859-1") do |row|
      zipped = headers.zip(row)
      hashed = Hash[zipped]
      next if hashed["DESCRICAO_CARGO"] != "VEREADOR"
      puts hashed.inspect
      campaing_state = State.find_or_create_by(name: hashed["SIGLA_UF"])

      campaing_city = City.find_or_create_by(name:  hashed["DESCRICAO_UE"].titleize_latin, state: campaing_state, tse_id: hashed["SIGLA_UE"])

      campaing_job = Job.find_or_create_by(name: hashed["DESCRICAO_OCUPACAO"].titleize_latin , tse_id: hashed["CODIGO_OCUPACAO"])

      campaing_result = StatusResult.find_or_create_by(name: hashed["DESC_SIT_TOT_TURNO"].titleize_latin , tse_id: hashed["COD_SIT_TOT_TURNO"])

      campaing_civil = CivilStatus.find_or_create_by(name: hashed["DESCRICAO_ESTADO_CIVIL"].titleize_latin , tse_id: hashed["CODIGO_ESTADO_CIVIL"])

      campaing_education_level = EducationLevel.find_or_create_by(name: hashed["DESCRICAO_GRAU_INSTRUCAO"].titleize_latin , tse_id: hashed["COD_GRAU_INSTRUCAO"])

      campaing_application = StatusApplication.find_or_create_by(name: hashed["DES_SITUACAO_CANDIDATURA"].titleize_latin , tse_id: hashed["COD_SITUACAO_CANDIDATURA"])

      campaing_party = Party.find_or_create_by(name: hashed["NOME_PARTIDO"].titleize_latin, number: hashed["CODIGO_CARGO"], acronym: hashed["SIGLA_PARTIDO"])

      campaing_coaltition = Coalition.find_or_create_by(name: hashed["NOME_LEGENDA"].titleize_latin , tse_id: hashed["CODIGO_LEGENDA"], acronym: hashed["SIGLA_LEGENDA"], content: hashed["COMPOSICAO_LEGENDA"])

      CoalitionParty.find_or_create_by(coalition: campaing_coaltition, party: campaing_party)

      politian_state = State.find_or_create_by(name: hashed["SIGLA_UF_NASCIMENTO"])
      politian_city = nil
      politian_city = City.find_or_create_by(name:  hashed["NOME_MUNICIPIO_NASCIMENTO"].titleize_latin, state: politian_state, tse_id: hashed["CODIGO_MUNICIPIO_NASCIMENTO"])

      campaing_politian = Politian.find_or_create_by(cpf: hashed["CPF_CANDIDATO"], name: hashed["NOME_CANDIDATO"].titleize_latin, birth_date: Date.parse(hashed["DATA_NASCIMENTO"]), gender: hashed["CODIGO_SEXO"], nationality: hashed["DESCRICAO_NACIONALIDADE"].titleize_latin, birth_city: politian_city, voter_number: hashed["NUM_TITULO_ELEITORAL_CANDIDATO"])

      campaing = Campaing.find_or_create_by(generate_date: Date.parse(hashed["DATA_GERACAO"]), tse_id: hashed["SEQUENCIAL_CANDIDATO"], budget: hashed["DESPESA_MAX_CAMPANHA"], civil_status: campaing_civil, number: hashed["NUMERO_CANDIDATO"], name_campain: hashed["NOME_URNA_CANDIDATO"].titleize_latin,
      coalition: campaing_coaltition, party: campaing_party, job: campaing_job, politian: campaing_politian, city: campaing_city, education_level: campaing_education_level, status_application: campaing_application, election: election, status_result: campaing_result)
      puts f
      puts campaing.inspect
    end

  end
end
