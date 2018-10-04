# frozen_string_literal: true

# class that create school rooms
class SchoolRoomsController < ApplicationController
  before_action :logged_in?
  before_action :authenticate_coordinator?, except: [:index]
  # before_action :set_search_params, only: [:index]

  def new
    @school_room = SchoolRoom.new
    @all_courses = Course.all
  end

  def create
    @school_room = SchoolRoom.new(school_rooms_params)
    @school_room.name.upcase!
    @all_courses = Course.all
    if @school_room.save
      redirect_to school_rooms_path, flash: { success: 'Turma criada' }
    else
      ocurred_errors(@school_room)
      render :new
    end
  end

  def edit
    @school_room = SchoolRoom.find(params[:id])
    @all_courses = Course.all
  end

  def index
    if permission[:level] == 1
      @my_school_rooms = SchoolRoom.joins(:discipline).merge(
        Discipline.order(:name).where(department_id: department_by_coordinator)
      ).order(:name)
      @disciplines = discipline_of_department(department_by_coordinator)
                     .order(:name)
                     .map(&:name)

    else
      @my_school_rooms = SchoolRoom.all
    end

    @my_school_rooms = apply_filters(@my_school_rooms)

    @my_school_rooms = @my_school_rooms.paginate(page: params[:page], per_page: 10)
    @allocation_options = [
      ['Alocado', 'allocated'],
      ['Desalocado', 'non_allocated']
    ]
    # needs refactoring
    # sort_school_rooms_by_allocation
  end

  def search_disciplines
    @search_attribute = params[:current_search][:search]
    @disciplines = discipline_of_department(department_by_coordinator).where(
      'name LIKE :search', search: "%#{@search_attribute}%"
    ).order(:name)
    if @disciplines.present?
      @school_rooms = school_rooms_of_disciplines(@disciplines)
    else
      flash[:notice] = 'Nenhuma turma encontrada'
      redirect_to school_rooms_path
    end
  end

  def search_courses
    require 'json'
    search_param = params[:code]
    courses = Course.find_by(code: search_param)
    render inline: courses.to_json
  end

  def update
    @school_room = SchoolRoom.find(params[:id])
    @all_courses = Course.all
    if @school_room.update_attributes(school_rooms_params_update)
      success_message = 'A turma foi alterada com sucesso'
      redirect_to school_rooms_path, flash: { success: success_message }
    else
      ocurred_errors(@school_room)
      render :edit
    end
  end

  def destroy
    @school_room = SchoolRoom.find(params[:id])
    coordinator = Coordinator.find_by(user_id: current_user.id)
    if permission[:level] == 1 &&
       coordinator.course.department == @school_room.discipline.department
      @school_room.destroy
      flash[:success] = 'A turma foi excluída com sucesso'
    else
      flash[:error] = 'Permissão negada'
    end
    redirect_to school_rooms_path
  end

  private

  def school_rooms_params
    params[:school_room].permit(
      :name,
      :discipline_id,
      :vacancies,
      course_ids: [],
      category_ids: []
    )
  end

  def school_rooms_params_update
    params[:school_room].permit(
      :discipline_id,
      :vacancies,
      course_ids: [],
      category_ids: []
    )
  end

  def apply_filters(query)
    @params = search_params
    if !@params.nil?
      if @params.has_key?(:search) && !@params.fetch(:search).blank?
        name = @params.fetch(:search)
        query = query
        .joins(:discipline)
        .where(disciplines: { name: name })
      end
      
      if @params.has_key?(:allocation)
        allocation = @params.fetch(:allocation)
        if allocation == 'allocated'
          query = query.joins(:allocations)
        elsif allocation == 'non_allocated'
          query = query.left_outer_joins(:allocations)
        end
      end
    end
    query
  end

  def search_params
    if params[:current_search].present?
      params.require(:current_search).permit(:search, :allocation)
    else
      ActionController::Parameters.new(search: '', allocation: '')
    end
  end
end
