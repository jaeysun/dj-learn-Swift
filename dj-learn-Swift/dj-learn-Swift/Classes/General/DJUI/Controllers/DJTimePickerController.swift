//
//  DJTimePickerController.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/8/13.
//  Copyright © 2021 S.J. All rights reserved.
//

import UIKit

enum DJTimePickerMode {
    case yearMonthDay
    case hourMinute
}

class DJTimerPickerRowView: UIView {
    
    var titleLabel: UILabel!
    
    var content: String {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text ?? ""
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.edges.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias DJTimerPickerComplete = (_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int) -> Void
class DJTimePickerController: UIViewController {
    
    private var toolBar: UIView!
    private var titleLabel: UILabel!
    private var closeButton: UIButton!
    private var confirmButton: UIButton!
    private var pickView: UIPickerView!
    // 年月日时分
    private let years: Array<Int> = [Int](2000...2060)
    private let months: Array<Int> = [Int](01...12)
    private var days: Array<Int> = [Int](01...30)
    private let hours: Array<Int> = [Int](01...24)
    private let minutes: Array<Int> = [Int](01...60)
    
    private var mode: DJTimePickerMode!
    
    var selectedYear: Int = 2021
    var selectedMonth: Int = 8
    var selectedDay: Int = 13
    var selectedHour: Int = 17
    var selectedMinute: Int = 38
    
    var pickedClosure: DJTimerPickerComplete?
    
    init(mode: DJTimePickerMode) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .custom
        let sW = UIScreen.main.bounds.size.width
        self.preferredContentSize = CGSize(width: sW, height: 270)
        self.transitioningDelegate = self
        self.mode = mode
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configSubviews()
        configDate()
        
    }
    
    // MARK: - Action
    @objc fileprivate func confirmButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        guard let picked = pickedClosure else { return }
        picked(selectedYear, selectedMonth, selectedDay, selectedHour, selectedMinute)
    }
    
    @objc fileprivate func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private Method
    // 计算某月的天数
    fileprivate func dayCount(in year: Int, month: Int) -> Int {
        let calendar = Calendar.current
         
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        guard let startDate = calendar.date(from: startComps) else { return 0 }

        
        var endComps = DateComponents()
        endComps.day = 1
        endComps.month = month == 12 ? 1 : month + 1
        endComps.year = month == 12 ? year + 1 : year
        guard let endDate = calendar.date(from: endComps)  else { return 0 }
        let diff = calendar.dateComponents([.day], from: startDate, to: endDate)
        guard let count = diff.day else { return 0 }
        return count
    }
    
    // MARK- Config
    fileprivate func configSubviews() {
        self.view.backgroundColor = .white
        
        toolBar = UIView()
        self.view.addSubview(toolBar)
        toolBar.snp.makeConstraints { maker in
            maker.left.top.right.equalTo(self.view)
            maker.height.equalTo(50.0)
        }
        
        titleLabel = UILabel()
        titleLabel.text = "出发时间"
        titleLabel.textAlignment = .center
        toolBar.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.center.equalTo(toolBar)
        }
        
        closeButton = UIButton(type: .custom)
        let closeImage = UIImage(named: "icon_delete")
        closeButton.setImage(closeImage, for: .normal)
        toolBar.addSubview(closeButton)
        closeButton.snp.makeConstraints { maker in
            maker.top.bottom.left.equalTo(toolBar)
            maker.width.equalTo(54.0)
        }
        closeButton.addTarget(self, action: #selector(closeButtonAction(_:)), for: .touchUpInside)
        
        confirmButton = UIButton(type: .custom)
        let confirmImage = UIImage(named: "icon_correct")
        confirmButton.setImage(confirmImage, for: .normal)
        toolBar.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { maker in
            maker.top.bottom.right.equalTo(toolBar)
            maker.width.equalTo(54.0)
        }
        confirmButton.addTarget(self, action: #selector(confirmButtonAction(_:)), for: .touchUpInside)
       
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(hex: 0xE5E5E5, alpha: 1)
        toolBar.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { maker in
            maker.left.bottom.right.equalTo(toolBar)
            maker.height.equalTo(1)
        }
  
        pickView = UIPickerView()
        pickView.delegate = self
        self.view.addSubview(pickView)
        pickView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(toolBar.snp.bottom).offset(20.0)
            make.bottom.equalTo(self.view).offset(-34.0)
        }
    }

    fileprivate func configDate() {
        let calendar:Calendar = Calendar.current
        let now = Date()
        let year = calendar.component(.year, from: now)
        let month = calendar.component(.month, from: now)
        let day = calendar.component(.day, from: now)
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        
        let dayCount = self.dayCount(in: year, month: month)
        days = [Int](1...dayCount)
        
        selectedYear = year
        selectedMonth = month
        selectedDay = day
        selectedHour = hour
        selectedMinute = minute
        
        if self.mode == .hourMinute {
            self.pickView.selectRow(hour - 1, inComponent: 0, animated: false)
            self.pickView.selectRow(minute - 1, inComponent: 1, animated: false)
        }
        
        if self.mode == .yearMonthDay {
            self.pickView.selectRow(year - 2000, inComponent: 0, animated: false)
            self.pickView.selectRow(month - 1, inComponent: 1, animated: false)
            self.pickView.selectRow(day - 1, inComponent: 2, animated: false)
        }
    }
}

extension DJTimePickerController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if mode == .hourMinute {
            return 2
        }
        if mode == .yearMonthDay {
            return 3
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if mode == .hourMinute {
            switch component {
            case 0:
                return hours.count
            case 1:
                return minutes.count
            default:
                return 0
            }
        }
        
        if mode == .yearMonthDay {
            switch component {
            case 0:
                return years.count
            case 1:
                return months.count
            case 2:
                return days.count
            default:
                return 0
            }
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if mode == .hourMinute {
            switch component {
            case 0:
                self.selectedHour = self.hours[row]
            case 1:
                self.selectedMinute = self.minutes[row]
            default:
                break
            }
        }
        if mode == .yearMonthDay {
            switch component {
            case 0:
                self.selectedYear = self.years[row]
            case 1:
                self.selectedMonth = self.months[row]
                let dayCount = self.dayCount(in: self.selectedYear, month: self.selectedMonth)
                self.days = [Int](1...dayCount)
                self.pickView.reloadComponent(2)
            case 2:
                self.selectedDay = self.days[row]
            default:
                break
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var rowTitle = ""
        if mode == .hourMinute {
            switch component {
            case 0:
                rowTitle = String(format: "%02d", hours[row])
                break
            case 1:
                rowTitle = String(format: "%02d", minutes[row])
                break
            default:
                break
            }
        }
        
        if mode == .yearMonthDay {
            switch component {
            case 0:
                rowTitle = String(format: "%d年", years[row])
            case 1:
                rowTitle = String(format: "%02d月", months[row])
            case 2:
                rowTitle = String(format: "%02d日", days[row])
            default:
                break
            }
        }
        let rowView = DJTimerPickerRowView(frame: .zero)
        rowView.content = rowTitle
        return rowView
    }
}

// PickView 相关
extension DJTimePickerController: UIPickerViewDelegate  {
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 110
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
}

// 弹出动画相关
extension DJTimePickerController: UIViewControllerTransitioningDelegate {
   
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = DJPresentationController(presentedViewController: presented, presenting: presenting)
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DJPresentationAnimatedTransitoning(with: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DJPresentationAnimatedTransitoning(with: false)
    }
}

class DJPresentationController: UIPresentationController {
    // 背景图片点击事件
    @objc fileprivate func dimmingViewTapAction(_ sender: UITapGestureRecognizer) {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }

    var dimmingView: UIView!
    var presentationWrappingView: UIView!
    override var presentedView: UIView? {
        return self.presentationWrappingView
    }

    // 视图最终的Frame
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = self.containerView else { return .zero }
        let containerViewBounds = containerView.bounds
        let presentedViewContentSize = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: containerViewBounds.size)

        let x: CGFloat = 0.0
        let y = containerViewBounds.size.height - presentedViewContentSize.height
        let width = presentedViewContentSize.width
        let height = presentedViewContentSize.height
        let presentedViewControllerFrame = CGRect(x: x, y: y, width: width, height: height)
        
        return presentedViewControllerFrame
    }
    
    // 管理器
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.modalPresentationStyle = .custom
    }
    
    // 弹出
    override func presentationTransitionWillBegin() {
         
        guard let presentedViewControllerView = super.presentedView else { return }
        let presentationWrapperView = UIView(frame: self.frameOfPresentedViewInContainerView)
        self.presentationWrappingView = presentationWrapperView
        
        let presentationRoundedCornerView = UIView(frame: presentationWrapperView.bounds)
        presentationRoundedCornerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        presentationRoundedCornerView.layer.cornerRadius = 0
        presentationRoundedCornerView.layer.masksToBounds = true
        
        let presentedViewControllerWrapperView = UIView(frame: presentationRoundedCornerView.bounds)
        presentedViewControllerWrapperView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Add presentedViewControllerView -> presentedViewControllerWrapperView.
        presentedViewControllerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        presentedViewControllerView.frame = presentedViewControllerWrapperView.bounds
        presentedViewControllerWrapperView.addSubview(presentedViewControllerView)
        // Add presentedViewControllerWrapperView -> presentationRoundedCornerView.
        presentationRoundedCornerView.addSubview(presentedViewControllerWrapperView)
        // Add presentationRoundedCornerView -> presentationWrapperView.
        presentationWrapperView.addSubview(presentationRoundedCornerView)

        
        // dimmingView
        guard let containerView = self.containerView else { return }
        let dimmingView = UIView(frame: containerView.bounds)
        dimmingView.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let tapGesture =  UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapAction(_:)))
        dimmingView.addGestureRecognizer(tapGesture)
        self.dimmingView = dimmingView
        containerView.addSubview(dimmingView)
        
        // fade in the dimmingView alongside the presentation animation.
        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        self.dimmingView.alpha = 0
        transitionCoordinator?.animate(alongsideTransition: { context in
            self.dimmingView.alpha = 0.5;
        }, completion: nil)
        
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if (!completed) {
            self.presentationWrappingView = nil;
            self.dimmingView = nil;
        }
    }
    
    
    // 消失
    override func dismissalTransitionWillBegin() {
        // fade in the dimmingView alongside the presentation animation.
        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: { context in
            self.dimmingView.alpha = 0;
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if (completed) {
            self.presentationWrappingView = nil;
            self.dimmingView = nil;
        }
    }

    //
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        self.containerView?.setNeedsLayout()
    }

    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return container.preferredContentSize
    }
}

// 动画
class DJPresentationAnimatedTransitoning: NSObject, UIViewControllerAnimatedTransitioning {
    var isPresented: Bool = false
    
    init(with presented: Bool) {
        super.init()
        self.isPresented = presented
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresented {
            animationForPresented(with: transitionContext)
        }
        animationForDismissed(with: transitionContext)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animationForPresented(with transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowRadius = 5.0
        containerView.addSubview(presentedView)
        
        presentedView.alpha = 0
        let comppetionFrame = presentedView.frame
        let sH =  UIScreen.main.bounds.size.height
        let sW =  UIScreen.main.bounds.size.height
        presentedView.frame = CGRect(x: 0, y: sH, width: sW, height: 0)
        UIView.animate(withDuration: 0.3) {
            presentedView.alpha = 1
            presentedView.frame = comppetionFrame
        } completion: { finished in
            transitionContext.completeTransition(true)
        }
    }
    
    func animationForDismissed(with transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedView = transitionContext.view(forKey: .from) else { return }
        let sH =  UIScreen.main.bounds.size.height
        let sW =  UIScreen.main.bounds.size.height
        UIView.animate(withDuration: 0.3) {
            presentedView.alpha = 0
            presentedView.frame = CGRect(x: 0, y: sH, width: sW, height: 0)
        } completion: { finished in
            presentedView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}
