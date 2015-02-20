class CardsController < ApplicationController

    def sort
        cards= params[:card]
        cards.each.with_index do |card, index|
            Card.find(card).update(position: (index + 1))
        end
        respond_to do |format|
            format.js {head :no_content}
            
        end

    end

    def create
        @project = Project.find(params[:project_id])
        card_title = "Card #{Card.last.id + 1}"
        if @project.cards.last
            position = @project.cards.last.position + 1
        else
            position = 1
        end
        @card = Card.create(title: card_title, body: "Something brilliant here...", project: @project, position: position)
        respond_to do |format|
            format.html {redirect_to root_path}
            format.js
        end
    end

    def destroy
        @card = Card.find(params[:id])
        @card.destroy
        respond_to do |format|
            format.html {redirect_to root_path, notice: "Card was deleted"}
            format.js { head :no_content }
        end
    end

    def update
        @card = Card.find(params[:id])
        respond_to do |format|
        if @card.update_attributes(params.require(:card).permit(:title, :body))
          format.html { redirect_to(@card.project, :notice => 'Card was successfully updated.') }
          format.json { respond_with_bip(@card) }
        else
          format.html { render :action => "edit" }
          format.json { respond_with_bip(@card) }
        end
    end
    end
end

