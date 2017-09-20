namespace :twitter do
  task :all => [:scan, :remove_obsolete] do
  end

  desc "Scans all Twitter hashtags and saves tweets into database"
  task scan: :environment do
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
      TwitterWorker.perform_async(hashtag)
    }
  end

  desc "Removes tweets older than 12 hours ago"
  task remove_obsolete: :environment do
    TwitterRemover.perform_async()
  end

end
