describe 'layouts/_flash.html.haml' do
  before do
    flash[:success] = 'some success message'
    flash[:error] = 'some error message'
    flash[:alert] = 'some alert message'
    flash[:notice] = 'some notice message'
    render
  end

  it 'displays all alerts' do
    assert_select '.alert', {count: 4}
  end

  it 'formats success alerts' do
    assert_select '.alert.alert-success', {text: 'some success message', count: 1}
  end

  it 'formats error alerts' do
    assert_select '.alert.alert-danger', {text: 'some error message', count: 1}
  end

  it 'formats alert alerts' do
    assert_select '.alert.alert-warning', {text: 'some alert message', count: 1}
  end

  it 'formats notice alerts' do
    assert_select '.alert.alert-info', {text: 'some notice message', count: 1}
  end
end
