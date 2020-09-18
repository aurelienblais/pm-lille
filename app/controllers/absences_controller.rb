class AbsencesController < ApplicationController
  def create
    if absence_params[:absence_type_id].to_i.zero?
      absence = Absence.find_by absence_params.except(:absence_type_id)
      absence.destroy!
      head :ok
    else
      if Absence.create!(absence_params)
        head :ok
      else
        head :internal_server_error
      end
    end
  end

  private

  def absence_params
    params.require(:absence).permit(
      :agent_id,
      :absence_type_id,
      :date
    )
  end
end
