class StaticPagesController < ApplicationController
    def index
        @status_options = ['Todas', 'Condesa', 'Del Valle', 'Roma', 'Doctores']
    end
end

