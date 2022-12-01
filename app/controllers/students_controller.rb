class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
        render json: Student.all, status: :ok
    end

    def show
        student = Student.find(params[:id])
        render json: student, status: :ok
    end
    def create
        student = Student.create!(student_params)
        render json: student, status: :creeated 
    end

    def update
        student = Student.find_by(id: params[:id])
        student.update(student_params)
        render json: student, status: :ok
    end

    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end


    private

    def record_not_found
        render json: {error: "Student not found"}, status: :not_found
    end

    def record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :uprocessable_entity
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end
end
