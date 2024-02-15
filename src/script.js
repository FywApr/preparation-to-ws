const schedule = {
  groups: {
    1: "РПО-311",
    2: "РПО-211",
  },
  subjects: {
    1: "Основы философии",
    2: "База данных SQL",
    3: "Основы права",
    4: "Базы данных",
    5: "Микропроцессорная техника",
    6: "Программирование в офисных программ",
    7: "ООП",
    8: "Основы предпринимательской деятельности",
    9: "Физ. культура",
    10: "Разработка WEB-дизайна",
    11: "Основы политологии",
    12: "Культурология",
    13: "Мобильная робототехника",
  },
  people: {
    1: "Думан Калтаев",
    2: "Иван Ильев",
    3: "Ералы Гайрат",
    4: "Максим Беляков",
    5: "Александр Ненашев",
    6: "Вадим Киблер",
    7: "Никита Шинкаренко",
    8: "Мирас Сарсен",
    9: "Ермек Садвакасов",
    10: "Армен Мелкумян",
    11: "Владимир Валериевич",
    12: "Ардак Булумбаев",
    13: "Елена Сычева",
    14: "Валентина Простоквашина",
    15: "Батырхан Жунусов",
    16: "Ляззат Исабекова",
  },
  subject_info: {
    1: {
      subject: 1,
      teacher: 12,
    },
    2: {
      subject: 2,
      teacher: 11,
    },
    3: {
      subject: 3,
      teacher: 12,
    },
    4: {
      subject: 4,
      teacher: 11,
    },
    5: {
      subject: 5,
      teacher: 13,
    },
    6: {
      subject: 6,
      teacher: 14,
    },
    7: {
      subject: 7,
      teacher: 12,
    },
    8: {
      subject: 8,
      teacher: 16,
    },
    9: {
      subject: 9,
      teacher: 15,
    },
    10: {
      subject: 10,
      teacher: 12,
    },
    11: {
      subject: 11,
      teacher: 12,
    },
    12: {
      subject: 12,
      teacher: 11,
    },
    13: {
      subject: 13,
      teacher: 12,
    },
  },
  schedule: {
    1: {
      4: {
        group: 1,
        subject_info: 1,
        week_type: "",
      },
      5: {
        group: 1,
        subject_info: 2,
        week_type: "",
      },
      6: {
        group: 1,
        subject_info: 3,
        week_type: "",
      },
    },
    2: {
      4: {
        group: 1,
        subject_info: 4,
        week_type: "",
      },
      5: {
        group: 1,
        subject_info: 5,
        week_type: "",
      },
      6: {
        group: 1,
        subject_info: 5,
        week_type: "",
      },
      7: {
        group: 1,
        subject_info: 6,
        week_type: "",
      },
    },
  },
};

function getDay(day) {
  const table = document.createElement("TABLE");
  const thead = document.createElement("THEAD");
  const tbody = document.createElement("TBODY");

  let tr = document.createElement("TR");
  let th = document.createElement("TH");
  let th1 = document.createElement("TH");
  let th2 = document.createElement("TH");
  let th3 = document.createElement("TH");

  th.appendChild(document.createTextNode("Преподаватель"));
  th1.appendChild(document.createTextNode("Предмет"));
  th2.appendChild(document.createTextNode("Группа"));
  th3.appendChild(document.createTextNode("Пара"));
  tr.appendChild(th);
  tr.appendChild(th1);
  tr.appendChild(th2);
  tr.appendChild(th3);
  thead.appendChild(tr);
  table.appendChild(thead);
  table.appendChild(tbody);

  for (lesson in schedule.schedule[day]) {
    let tr = document.createElement("TR");
    let td = document.createElement("TD");
    let td1 = document.createElement("TD");
    let td2 = document.createElement("TD");
    let td3 = document.createElement("TD");

    let subjectInfoId = schedule.schedule[day][lesson].subject_info;
    let subjectName = schedule.subjects[subjectInfoId];
    let teacherId = schedule.subject_info[subjectInfoId].teacher;
    let teacherName = schedule.people[teacherId];
    let groupId = schedule.schedule[day][lesson].group;
    let groupName = schedule.groups[groupId];

    td.appendChild(document.createTextNode(teacherName));
    td1.appendChild(document.createTextNode(subjectName));
    td2.appendChild(document.createTextNode(groupName));
    td3.appendChild(document.createTextNode(lesson));
    tr.appendChild(td);
    tr.appendChild(td1);
    tr.appendChild(td2);
    tr.appendChild(td3);
    table.appendChild(tr);
  }
  return table;
}

window.document.addEventListener("DOMContentLoaded", () => {
  const hrefStr = window.location.href.toString();
  const navList = document.getElementById("nav-list");
  const langList = document.getElementById("lang-list");

  // Получить расписание
  const getSchedule = () => {
    window.document.body.appendChild(getDay(1));
  };

  getSchedule();

  // Получение данных с API
  async function getData() {
    const response = await fetch(
      `https://127.0.0.1:8000/api.php${hrefStr.substring(
        hrefStr.indexOf("?"),
        hrefStr.length
      )}`
    );
    const data = await response.json();
    let ul = document.createElement("UL");
    for (let i = 0; i < data.length; i++) {
      let li = document.createElement("LI");
      let textNode = document.createTextNode(data[i].name);
      li.appendChild(textNode);
      ul.appendChild(li);
    }
    window.document.body.appendChild(ul);
  }

  getData();

  // Работа со страницами
  for (let i = 0; i < navList.children.length; i++) {
    navList.children[i].addEventListener("click", (event) => {
      let page = event.target.getAttribute("data-link");

      // Назначение ссылки
      // если нет lang
      if (!hrefStr.includes("?lang")) {
        if (page == null) {
          let deletingPage = hrefStr.substring(
            hrefStr.lastIndexOf("?page"),
            hrefStr.length
          );
          window.location.href = hrefStr.replace(deletingPage, ``);
        } else if (hrefStr.includes("?page")) {
          let oldPage = `${hrefStr.substring(
            hrefStr.lastIndexOf("?"),
            hrefStr.length
          )}`;
          window.location.href = hrefStr.replace(oldPage, `?page=${page}`);
        } else {
          window.location.href += `?page=${page}`;
        }
      } else {
        // если есть lang
        if (page == null) {
          let deletingPage = hrefStr.substring(
            hrefStr.lastIndexOf("&page"),
            hrefStr.length
          );
          window.location.href = hrefStr.replace(deletingPage, ``);
        } else if (hrefStr.includes("&page")) {
          let oldPage = `${hrefStr.substring(
            hrefStr.lastIndexOf("&"),
            hrefStr.length
          )}`;
          window.location.href = hrefStr.replace(oldPage, `&page=${page}`);
        } else {
          window.location.href += `&page=${page}`;
        }
      }
    });

    // Назначение класса
    if (
      window.location.href.includes(
        navList.children[i].children[0].getAttribute("data-link")
      )
    ) {
      while (navList.getElementsByClassName("active").length > 0)
        navList.getElementsByClassName("active")[0].removeAttribute("class");
      navList.children[i].children[0].className = "active";
    } else if (!hrefStr.includes("page")) {
      while (navList.getElementsByClassName("active").length > 0)
        navList.getElementsByClassName("active")[0].removeAttribute("class");
      navList.children[0].children[0].className = "active";
    }
  }

  // Работа с языком
  for (let i = 0; i < langList.children.length; i++) {
    langList.children[i].addEventListener("click", (event) => {
      let lang = event.target.getAttribute("data-lang");
      let oldLang = hrefStr.substring(
        hrefStr.indexOf("=") + 1,
        hrefStr.indexOf("=") + 3
      );

      // Назначение ссылки
      if (hrefStr.includes("?lang")) {
        window.location.href = window.location.href.replace(oldLang, lang);
      } else if (lang && !hrefStr.includes("page")) {
        window.location.href += `?lang=${lang}`;
      } else if (lang && hrefStr.includes("page")) {
        let firstHalf = hrefStr.substring(0, hrefStr.lastIndexOf("/") + 1);
        let secondHalf = hrefStr.substring(
          hrefStr.lastIndexOf("/") + 1,
          hrefStr.length
        );

        window.location.href =
          firstHalf + `?lang=${lang}` + secondHalf.replace("?", "&");
      }
    });

    // Назначение класса
    if (
      window.location.href.includes(
        langList.children[i].children[0].getAttribute("data-lang")
      )
    ) {
      while (langList.getElementsByClassName("active").length > 0)
        langList.getElementsByClassName("active")[0].removeAttribute("class");
      langList.children[i].children[0].className = "active";
    } else if (!hrefStr.includes("?lang")) {
      while (langList.getElementsByClassName("active").length > 0)
        langList.getElementsByClassName("active")[0].removeAttribute("class");
      langList.children[0].children[0].className = "active";
    }
  }
});
