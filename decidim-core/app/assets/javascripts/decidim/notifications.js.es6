$(() => {
  const $section = $('section#unread-notifications');
  $section.on('click', '.mark-as-read-button', (event) => {
    $(event.target).parents('.card--list__data').hide();
  })
});
