# frozen_string_literal: true

# Classe responsavel por gerar relatorio por turma
class ReportsSchoolRoomsController < ApplicationController
  def school_reports; end

  def report_school_room_not_allocated
    @allocations = Allocation.all
    allocated_school_room_ids = []

    @allocations.each do |allocation|
      allocated_school_room_ids << allocation.school_room_id
    end
    @unallocated_school_rooms = SchoolRoom.where('id NOT IN (?)', allocated_school_room_ids)
    # if @school_room.nil?
    #   return @sem_school_room_not_allocation = 'Nao foram encontradas
    #                                     turmas sem alocacao'
    # else
    #   return @school_room
  end

  def report_school_room_all
    report_school_room_not_allocated
  end

  def report_school_room_allocated
    @allocations = Allocation.all
    # if @allocation.nil?
    #   return @sem_allocation = 'Nao foram encontradas turmas alocadas'
    # else
    #   return @allocation
  end
end
