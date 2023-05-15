import data.Data;
import model.Person;
import view.LoginView;

/// 外卖大作业
public class Main {
    /// 从这里启动
    public static void main(String[] args) {
        System.out.println("来点份外卖吧!");
        Data.init();
        new LoginView();
    }
}
