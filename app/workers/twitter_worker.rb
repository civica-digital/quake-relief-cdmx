require 'twitter_scanner'

class TwitterWorker
  include Sidekiq::Worker

  def perform(*args)
    hashtags = %w(
      #sismo
      #CDMX
      #SismoMexico
      #FuerzaMexico
      #prayformexico
      #condesa
      #roma
      #laroma
      #mexico
      #TenemosSismo
      #Narvarte
      #niñosheroes
      #sismocdmx
      #delvalle
      #delegacionbenitojuarez
      #ayuda
      #puebla
      #terremoto
      #temblor
      sismomx
      #SOSCDMX
      #Sismomexico
      #Ayudasismo
      edificio dañado
    )
    hashtags.each { |hashtag|
      TwitterScanner.scan(hashtag)
    }
  end
end
