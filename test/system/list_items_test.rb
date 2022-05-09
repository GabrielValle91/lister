require "application_system_test_case"

class ListItemsTest < ApplicationSystemTestCase
  setup do
    @list_item = list_items(:one)
  end

  test "visiting the index" do
    visit list_items_url
    assert_selector "h1", text: "List items"
  end

  test "should create list item" do
    visit list_items_url
    click_on "New list item"

    check "Completed" if @list_item.completed
    fill_in "List", with: @list_item.list_id
    fill_in "Name", with: @list_item.name
    fill_in "Qty", with: @list_item.qty
    fill_in "Type", with: @list_item.type
    click_on "Create List item"

    assert_text "List item was successfully created"
    click_on "Back"
  end

  test "should update List item" do
    visit list_item_url(@list_item)
    click_on "Edit this list item", match: :first

    check "Completed" if @list_item.completed
    fill_in "List", with: @list_item.list_id
    fill_in "Name", with: @list_item.name
    fill_in "Qty", with: @list_item.qty
    fill_in "Type", with: @list_item.type
    click_on "Update List item"

    assert_text "List item was successfully updated"
    click_on "Back"
  end

  test "should destroy List item" do
    visit list_item_url(@list_item)
    click_on "Destroy this list item", match: :first

    assert_text "List item was successfully destroyed"
  end
end
