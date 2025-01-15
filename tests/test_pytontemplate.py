import pythontemplate


class TestMyClass:
    def test_init(self, my_fixture):
        status = my_fixture
        myclass = pythontemplate.MyClass(status)

        assert myclass.status
        pass
