import UIKit
import SnapKit

final class MainViewController: UIViewController {

        private enum Layout {
        static let inset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        enum Label {
            static let top: CGFloat = 20
            static let height: CGFloat = 550
        
        }

        enum Button {
            static let top: CGFloat = 20
            static let height: CGFloat = 80
       
        }

        enum Image {
            static let top: CGFloat = 50
            static let height: CGFloat = 700
       
        }
    }

    private var story = StoryBrain()

    private let label: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(25)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Question Text"
        label.textColor = .white
        return label
    }()

    private let changeOneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change 1", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 12
        button.tintColor = .white
        button.backgroundColor = .clear
        button.addTarget(
            self,
            action: #selector(didTapOneButton),
            for: .touchUpInside
        )
        return button
    }()
    
    private let changeTwoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change 2", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 12
        button.tintColor = .white
        button.backgroundColor = .clear
        button.addTarget(
            self,
            action: #selector(didTapTwoButton),
            for: .touchUpInside
        )
        return button
    }()

    private let imageBackground: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background")
        image.contentMode = .scaleAspectFill
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setupConstraints()

        updateQuestion()
    }

    @objc
    private func didTapOneButton() {
        changeOneButton.backgroundColor = .clear

        story.nextQuestion1()

        Timer.scheduledTimer(
            timeInterval: 0.2,
            target: self,
            selector: #selector(updateQuestion),
            userInfo: nil,
            repeats: false
        )
    }

    @objc
    private func didTapTwoButton() {
        changeTwoButton.backgroundColor = .clear
        story.nextQuestion2()

        Timer.scheduledTimer(
            timeInterval: 0.2,
            target: self,
            selector: #selector(updateQuestion),
            userInfo: nil,
            repeats: false
        )
    }

    @objc
    private func updateQuestion() {
        label.text = story.getQuestionText()
        changeOneButton.setTitle(story.getAnswerText1(), for: .normal)
        changeTwoButton.setTitle(story.getAnswerText2(), for: .normal)
    
        changeOneButton.backgroundColor = UIColor(hex: "#E8517A")
        changeTwoButton.backgroundColor = UIColor(hex: "#895CA5")
    }
}

// MARK: - Setup Constraints

private extension MainViewController {

    func addSubviews() {
        view.addSubview(imageBackground)
        view.addSubview(label)
        view.addSubview(changeOneButton)
        view.addSubview(changeTwoButton)
    }

    func setupConstraints() {
        imageBackground.snp.makeConstraints { make in
            make
                .top
                .equalTo(view.safeAreaLayoutGuide)
            make
                .leading.trailing.bottom
                .equalToSuperview()
        }

        label.snp.makeConstraints { make in
            make
                .top
                .equalTo(view.safeAreaLayoutGuide)
                .offset(Layout.Label.top)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(Layout.inset)
            make
                .height
                .equalTo(Layout.Label.height)
        }

        changeOneButton.snp.makeConstraints { make in
            make
                .top
                .equalTo(label.snp.bottom)
                .offset(Layout.Button.top)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(Layout.inset)
            make
                .height
                .equalTo(Layout.Button.height)
        }

        changeTwoButton.snp.makeConstraints { make in
            make
                .top
                .equalTo(changeOneButton.snp.bottom)
                .offset(Layout.Button.top)
            make
                .leading.trailing
                .equalToSuperview()
                .inset(Layout.inset)
            make
                .height
                .equalTo(Layout.Button.height)
        }
    }
}
