class ConditionObserver < ActiveRecord::Observer
  observe :host, :slice, :customer, :database, :site

  def initialize
    super
    @cache = {}
  end

  def after_create(record)
    check_model(record)
    @cache[record.class.name][record.id] = {:action => :create}
    true
  end

  def after_save(record)
    check_model(record)
    unless @cache[record.class.name].key?(record.id)
      @cache[record.class.name][record.id] = {:action => :update, :values => record.changes}
    end
    true
  end

  def before_destroy(record)
    check_model(record)
    @cache[record.class.name][record.id] = {:action => :destroy}
    true
  end

  def after_commit(record)
    Rails.logger.debug "=== Observer after_commit"
    check_model(record)
    @cache[record.class.name].keys.each do |id|
      action = @cache[record.class.name][id][:action]
      Rails.logger.debug "  = Processin '#{action}' for '#{record.class.name}' with ID=#{id}"
      case action
      when :create then
        Condition.create_model(record.class.name).map do |condition|
          Rails.logger.debug "  = Processin create conditions for job '#{condition.job.name}'"
          condition.job.start(record)
        end
      when :update then
        values = @cache[record.class.name][id][:values]
        fields = values.select{|attr,value| attr != "updated_at"}.collect{|attr,value| attr}.sort.join(",")
        Rails.logger.debug "Fields: #{fields}"
        Condition.update_model(record.class.name, fields).map do |condition|
          Rails.logger.debug "  = Processin update conditions for job '#{condition.job.name}'"
          condition.job.start(record, values)
        end
      when :destroy then
        Condition.destroy_model(record.class.name).map do |condition|
          Rails.logger.debug "  = Processin destroy conditions for job '#{condition.job.name}'"
          condition.job.start(record)
        end
      end
      @cache[record.class.name].delete(id)
    end
    true
  end

  private

  def check_model(record)
    unless @cache.key?(record.class.name)
      @cache[record.class.name] = {}
    end
  end

end
