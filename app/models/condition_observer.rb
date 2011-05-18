class ConditionObserver < ActiveRecord::Observer
  observe :host, :slice, :customer, :database, :site

  def initialize
    super
    @cache = {}
  end

  def after_create(record)
    check_model(record)
    add_model_action(record, :create)
    true
  end

  def after_save(record)
    check_model(record)
    unless @cache[record.class.name].key?(record.id)
      add_model_action(record, :update)
    end
    true
  end

  def before_destroy(record)
    check_model(record)
    add_model_action(record, :destroy)
    true
  end

  def after_commit(record)
    check_model(record)
    model = record.class.name

    @cache[model].keys.each do |id|
      action = @cache[model][id][:action]
      changes = @cache[model][id][:changes]
      attributes = @cache[model][id][:attributes]

      case action
        when :create then
          Condition.create_model(model).map {|condition| condition.job.start(attributes, changes)}
        when :update then
          fields = changes.select{|attr,value| attr != "updated_at"}.collect{|attr,value| attr}.sort.join(",")
          Condition.update_model(model, fields).map {|condition| condition.job.start(attributes, changes)}
        when :destroy then
          Condition.destroy_model(model).map {|condition| condition.job.start(attributes, changes)}
      end
      @cache[model].delete(id)
    end
    true
  end

  private

  def check_model(record)
    unless @cache.key?(record.class.name)
      @cache[record.class.name] = {}
    end
  end

  def add_model_action(record, action)
    changes = action == :update ? record.changes : {}
    @cache[record.class.name][record.id] = {:action => action, :changes => changes, :attributes => record.attributes}
  end

end
