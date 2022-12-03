class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
        render json: Instructor.all, status: :ok
    end

    def show
        instructor = Instructor.find(params[:id])
        render json: instructor, status: :ok
    end
    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created 
    end

    def update
        instructor = Instructor.find_by(id: params[:id])
        instructor.update(instructor_params)
        render json: instructor, status: :ok
    end

    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end


    private

    def record_not_found
        render json: {error: "Instructor not found"}, status: :not_found
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :uprocessable_entity
    end

    def instructor_params
        params.permit(:name)
    end


end
