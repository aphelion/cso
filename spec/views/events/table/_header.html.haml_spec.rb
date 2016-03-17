describe 'events/table/_header.html.haml' do
  before do
    render
  end

  describe 'structure' do
    it 'renders thead' do
      assert_select 'thead'
    end

    it 'renders a Build name column header' do
      assert_select 'thead tr th:nth-child(1)', {text: 'name'}
    end

    it 'renders a Build actions column header' do
      assert_select 'thead tr th:nth-child(2)', {text: 'actions'}
    end
  end
end
