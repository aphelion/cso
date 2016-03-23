module FlashHelper
  def alert_class_for_flash_type(flash_type)
    {
        success: 'alert-success',
        error: 'alert-danger',
        alert: 'alert-warning',
        notice: 'alert-info'
    }.with_indifferent_access[flash_type]
  end
end
