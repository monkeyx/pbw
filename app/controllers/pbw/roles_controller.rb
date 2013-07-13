module Pbw
  class RolesController < ApplicationController
    respond_to :json

    before_filter :authenticate_user!
    before_filter :is_super_admin?

    def index
      @roles = Role.all.keep_if{|i| i.name != "Super Admin"}
      render json: @roles
    end

    def show
      @role = Role.find(params[:id])
      @permissions = @role.permissions
      render json: {role: @role, permissions: @permissions}
    end

    def edit
      @role = Role.find(params[:id])
      @permissions = Permission.all.keep_if{|i| ["Part"].include? i.subject_class}.compact
      @role_permissions = @role.permissions.collect{|p| p.id}
      render json: {role: @role, permissions: @permissions, role_permissions: @role_permissions}
    end

    def update
      @role = Role.find(params[:id])
      @role.permissions = []
      @role.set_permissions(params[:permissions]) if params[:permissions]
      if @role.save
        render json: {notice: "Role updated"}
        return
      end
      render 'edit'
    end

    private

    def is_super_admin?
      redirect_to root_path and return unless current_user.super_admin?
    end
  end
end